Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882583AFB5E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jun 2021 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFVDZL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 23:25:11 -0400
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:49344 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFVDZK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 23:25:10 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0405597|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.122169-0.0347878-0.843044;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KW.vP4a_1624332173;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KW.vP4a_1624332173)
          by smtp.aliyun-inc.com(10.147.41.231);
          Tue, 22 Jun 2021 11:22:53 +0800
Date:   Tue, 22 Jun 2021 11:22:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: any idea about auto export multiple btrfs snapshots?
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <162432531379.17441.15110145423567943074@noble.neil.brown.name>
References: <20210621163441.428C.409509F4@e16-tech.com> <162432531379.17441.15110145423567943074@noble.neil.brown.name>
Message-Id: <20210622112253.DAEE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_60D155E100000000DAE9_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------_60D155E100000000DAE9_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,


> On Mon, 21 Jun 2021, Wang Yugui wrote:
> > Hi,
> > 
> > > > > It seems more fixes are needed.
> > > > 
> > > > I think the problem is that the submount doesn't appear in /proc/mounts.
> > > > "nfsd_fh()" in nfs-utils needs to be able to map from the uuid for a
> > > > filesystem to the mount point.  To do this it walks through /proc/mounts
> > > > checking the uuid of each filesystem.  If a filesystem isn't listed
> > > > there, it obviously fails.
> > > > 
> > > > I guess you could add code to nfs-utils to do whatever "btrfs subvol
> > > > list" does to make up for the fact that btrfs doesn't register in
> > > > /proc/mounts.
> > > 
> > > Another approach might be to just change svcxdr_encode_fattr3() and
> > > nfsd4_encode_fattr() in the 'FSIDSOJURCE_UUID' case to check if
> > > dentry->d_inode has a different btrfs volume id to
> > > exp->ex_path.dentry->d_inode.
> > > If it does, then mix the volume id into the fsid somehow.
> > > 
> > > With that, you wouldn't want the first change I suggested.
> > 
> > This is what I have done. and it is based on linux 5.10.44
> > 
> > but it still not work, so still more jobs needed.
> > 
> 
> The following is more what I had in mind.  It doesn't quite work and I
> cannot work out why.
> 
> If you 'stat' a file inside the subvol, then 'find' will not complete.
> If you don't, then it will.
> 
> Doing that 'stat' changes the st_dev number of the main filesystem,
> which seems really weird.
> I'm probably missing something obvious.  Maybe a more careful analysis
> of what is changing when will help.

we compare the trace output between crossmnt and btrfs subvol with some
trace, we found out that we need to add the subvol support to
follow_down().

btrfs subvol should be treated as virtual 'mount point' for nfsd in follow_down().

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/06/22


> NeilBrown
> 
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 9421dae22737..790a3357525d 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/namei.h>
>  #include <linux/module.h>
> +#include <linux/statfs.h>
>  #include <linux/exportfs.h>
>  #include <linux/sunrpc/svc_xprt.h>
>  
> @@ -575,6 +576,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
>  	int err;
>  	struct auth_domain *dom = NULL;
>  	struct svc_export exp = {}, *expp;
> +	struct kstatfs statfs;
>  	int an_int;
>  
>  	if (mesg[mlen-1] != '\n')
> @@ -604,6 +606,10 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
>  	err = kern_path(buf, 0, &exp.ex_path);
>  	if (err)
>  		goto out1;
> +	err = vfs_statfs(&exp.ex_path, &statfs);
> +	if (err)
> +		goto out3;
> +	exp.ex_fsid64 = statfs.f_fsid;
>  
>  	exp.ex_client = dom;
>  	exp.cd = cd;
> @@ -809,6 +815,7 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
>  	new->ex_anon_uid = item->ex_anon_uid;
>  	new->ex_anon_gid = item->ex_anon_gid;
>  	new->ex_fsid = item->ex_fsid;
> +	new->ex_fsid64 = item->ex_fsid64;
>  	new->ex_devid_map = item->ex_devid_map;
>  	item->ex_devid_map = NULL;
>  	new->ex_uuid = item->ex_uuid;
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index ee0e3aba4a6e..d3eb9a599918 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -68,6 +68,7 @@ struct svc_export {
>  	kuid_t			ex_anon_uid;
>  	kgid_t			ex_anon_gid;
>  	int			ex_fsid;
> +	__kernel_fsid_t		ex_fsid64;
>  	unsigned char *		ex_uuid; /* 16 byte fsid */
>  	struct nfsd4_fs_locations ex_fslocs;
>  	uint32_t		ex_nflavors;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..8144e6037eae 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2869,6 +2869,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	if (err)
>  		goto out_nfserr;
>  	if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
> +		       FATTR4_WORD0_FSID |
>  			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
>  	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
>  		       FATTR4_WORD1_SPACE_TOTAL))) {
> @@ -3024,6 +3025,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		case FSIDSOURCE_UUID:
>  			p = xdr_encode_opaque_fixed(p, exp->ex_uuid,
>  								EX_UUID_LEN);
> +			if (statfs.f_fsid.val[0] != exp->ex_fsid64.val[0] ||
> +			    statfs.f_fsid.val[1] != exp->ex_fsid64.val[1]) {
> +				/* looks like a btrfs subvol */
> +				p[-2] ^= statfs.f_fsid.val[0];
> +				p[-1] ^= statfs.f_fsid.val[1];
> +			}
>  			break;
>  		}
>  	}


--------_60D155E100000000DAE9_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="0001-nfsd-btrfs-subvol-support.txt"
Content-Disposition: attachment;
 filename="0001-nfsd-btrfs-subvol-support.txt"
Content-Transfer-Encoding: base64

RnJvbSA1N2U2YjNjZWM5YjhhYzM5NmI2NjFjMTkwNTExYWY4MDgzOWRkYmU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB3YW5neXVndWkgPHdhbmd5dWd1aUBlMTYtdGVjaC5jb20+CkRh
dGU6IFRodSwgMTcgSnVuIDIwMjEgMDg6MzM6MDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBuZnNk
OiBidHJmcyBzdWJ2b2wgc3VwcG9ydAoKKHN0cnVjdCBzdGF0ZnMpLmZfZnNpZDogCXVuaXEgYmV0
d2VlbiBidHJmcyBzdWJ2b2xzCihzdHJ1Y3Qgc3RhdCkuc3RfZGV2OiAJCXVuaXEgYmV0d2VlbiBi
dHJmcyBzdWJ2b2xzCihzdHJ1Y3Qgc3RhdHgpLnN0eF9tbnRfaWQ6CU5PVCB1bmlxIGJldHdlZW4g
YnRyZnMgc3Vidm9scywgYnV0IHlldCBub3QgdXNlZCBpbiBuZnMvbmZzZAoJa2VybmVsIHNhbXBs
ZXMvdmZzL3Rlc3Qtc3RhdHguYwoJCXN0eF9yZGV2X21ham9yL3N0eF9yZGV2X21pbm9yIHNlZW1z
IGJlIHRydW5jYXRlZCBieSBzb21ldGhpbmcKCQlsaWtlIG9sZF9lbmNvZGVfZGV2KCkvb2xkX2Rl
Y29kZV9kZXYoKT8KClRPRE86IChzdHJ1Y3QgbmZzX2ZhdHRyKS5mc2lkClRPRE86IEZTSURTT1VS
Q0VfRlNJRCBpbiBuZnMzeGRyLmMvbmZzeGRyLmMKLS0tCiBmcy9uZnNkL25mczN4ZHIuYyB8ICAy
ICstCiBmcy9uZnNkL25mczR4ZHIuYyB8IDE2ICsrKysrKysrKysrKy0tLS0KIGZzL25mc2QvbmZz
ZC5oICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBmcy9uZnNkL3Zmcy5jICAg
ICB8IDEwICsrKysrKysrLS0KIDQgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uZnNkL25mczN4ZHIuYyBiL2ZzL25mc2QvbmZz
M3hkci5jCmluZGV4IDcxNjU2NmQuLjBkZTI5NTMgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvbmZzM3hk
ci5jCisrKyBiL2ZzL25mc2QvbmZzM3hkci5jCkBAIC04NzcsNyArODc3LDcgQEAgY29tcG9zZV9l
bnRyeV9maChzdHJ1Y3QgbmZzZDNfcmVhZGRpcnJlcyAqY2QsIHN0cnVjdCBzdmNfZmggKmZocCwK
IAkJZGNoaWxkID0gbG9va3VwX3Bvc2l0aXZlX3VubG9ja2VkKG5hbWUsIGRwYXJlbnQsIG5hbWxl
bik7CiAJaWYgKElTX0VSUihkY2hpbGQpKQogCQlyZXR1cm4gcnY7Ci0JaWYgKGRfbW91bnRwb2lu
dChkY2hpbGQpKQorCWlmIChkX21vdW50cG9pbnQoZGNoaWxkKSB8fCB1bmxpa2VseShkX2lzX2J0
cmZzX3N1YnZvbChkY2hpbGQpKSkKIAkJZ290byBvdXQ7CiAJaWYgKGRjaGlsZC0+ZF9pbm9kZS0+
aV9pbm8gIT0gaW5vKQogCQlnb3RvIG91dDsKZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHhkci5j
IGIvZnMvbmZzZC9uZnM0eGRyLmMKaW5kZXggNWY1MTY5Yi4uZWUzMzVmYyAxMDA2NDQKLS0tIGEv
ZnMvbmZzZC9uZnM0eGRyLmMKKysrIGIvZnMvbmZzZC9uZnM0eGRyLmMKQEAgLTI0NTcsNyArMjQ1
Nyw3IEBAIHN0YXRpYyBfX2JlMzIgbmZzZDRfZW5jb2RlX3BhdGgoc3RydWN0IHhkcl9zdHJlYW0g
KnhkciwKIAkJaWYgKHBhdGhfZXF1YWwoJmN1ciwgcm9vdCkpCiAJCQlicmVhazsKIAkJaWYgKGN1
ci5kZW50cnkgPT0gY3VyLm1udC0+bW50X3Jvb3QpIHsKLQkJCWlmIChmb2xsb3dfdXAoJmN1cikp
CisJCQlpZiAobmZzZF9mb2xsb3dfdXAoJmN1cikpCiAJCQkJY29udGludWU7CiAJCQlnb3RvIG91
dF9mcmVlOwogCQl9CkBAIC0yNjQ4LDcgKzI2NDgsNyBAQCBzdGF0aWMgaW50IGdldF9wYXJlbnRf
YXR0cmlidXRlcyhzdHJ1Y3Qgc3ZjX2V4cG9ydCAqZXhwLCBzdHJ1Y3Qga3N0YXQgKnN0YXQpCiAJ
aW50IGVycjsKIAogCXBhdGhfZ2V0KCZwYXRoKTsKLQl3aGlsZSAoZm9sbG93X3VwKCZwYXRoKSkg
eworCXdoaWxlIChuZnNkX2ZvbGxvd191cCgmcGF0aCkpIHsKIAkJaWYgKHBhdGguZGVudHJ5ICE9
IHBhdGgubW50LT5tbnRfcm9vdCkKIAkJCWJyZWFrOwogCX0KQEAgLTI3MjgsNiArMjcyOCw3IEBA
IG5mc2Q0X2VuY29kZV9mYXR0cihzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3Qgc3ZjX2Zo
ICpmaHAsCiAJCS5kZW50cnkJPSBkZW50cnksCiAJfTsKIAlzdHJ1Y3QgbmZzZF9uZXQgKm5uID0g
bmV0X2dlbmVyaWMoU1ZDX05FVChycXN0cCksIG5mc2RfbmV0X2lkKTsKKwlib29sIGlzX2J0cmZz
X3N1YnZvbD0gZF9pc19idHJmc19zdWJ2b2woZGVudHJ5KTsKIAogCUJVR19PTihibXZhbDEgJiBO
RlNEX1dSSVRFT05MWV9BVFRSU19XT1JEMSk7CiAJQlVHX09OKCFuZnNkX2F0dHJzX3N1cHBvcnRl
ZChtaW5vcnZlcnNpb24sIGJtdmFsKSk7CkBAIC0yNzQ0LDcgKzI3NDUsOCBAQCBuZnNkNF9lbmNv
ZGVfZmF0dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IHN2Y19maCAqZmhwLAogCWlm
ICgoYm12YWwwICYgKEZBVFRSNF9XT1JEMF9GSUxFU19BVkFJTCB8IEZBVFRSNF9XT1JEMF9GSUxF
U19GUkVFIHwKIAkJCUZBVFRSNF9XT1JEMF9GSUxFU19UT1RBTCB8IEZBVFRSNF9XT1JEMF9NQVhO
QU1FKSkgfHwKIAkgICAgKGJtdmFsMSAmIChGQVRUUjRfV09SRDFfU1BBQ0VfQVZBSUwgfCBGQVRU
UjRfV09SRDFfU1BBQ0VfRlJFRSB8Ci0JCSAgICAgICBGQVRUUjRfV09SRDFfU1BBQ0VfVE9UQUwp
KSkgeworCQkgICAgICAgRkFUVFI0X1dPUkQxX1NQQUNFX1RPVEFMKSkgfHwKKwkJdW5saWtlbHko
aXNfYnRyZnNfc3Vidm9sKSkgewogCQllcnIgPSB2ZnNfc3RhdGZzKCZwYXRoLCAmc3RhdGZzKTsK
IAkJaWYgKGVycikKIAkJCWdvdG8gb3V0X25mc2VycjsKQEAgLTI4OTUsNyArMjg5NywxMyBAQCBu
ZnNkNF9lbmNvZGVfZmF0dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IHN2Y19maCAq
ZmhwLAogCQkJKnArKyA9IGNwdV90b19iZTMyKE1JTk9SKHN0YXQuZGV2KSk7CiAJCQlicmVhazsK
IAkJY2FzZSBGU0lEU09VUkNFX1VVSUQ6Ci0JCQlwID0geGRyX2VuY29kZV9vcGFxdWVfZml4ZWQo
cCwgZXhwLT5leF91dWlkLAorCQkJaWYgKHVubGlrZWx5KGlzX2J0cmZzX3N1YnZvbCkpeworCQkJ
CSpwKysgPSBjcHVfdG9fYmUzMihzdGF0ZnMuZl9mc2lkLnZhbFswXSk7CisJCQkJKnArKyA9IGNw
dV90b19iZTMyKHN0YXRmcy5mX2ZzaWQudmFsWzFdKTsKKwkJCQkqcCsrID0gY3B1X3RvX2JlMzIo
MCk7CisJCQkJKnArKyA9IGNwdV90b19iZTMyKDApOworCQkJfSBlbHNlCisJCQkJcCA9IHhkcl9l
bmNvZGVfb3BhcXVlX2ZpeGVkKHAsIGV4cC0+ZXhfdXVpZCwKIAkJCQkJCQkJRVhfVVVJRF9MRU4p
OwogCQkJYnJlYWs7CiAJCX0KZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzZC5oIGIvZnMvbmZzZC9u
ZnNkLmgKaW5kZXggY2I3NDJlMS4uMjdiYWFiYiAxMDA2NDQKLS0tIGEvZnMvbmZzZC9uZnNkLmgK
KysrIGIvZnMvbmZzZC9uZnNkLmgKQEAgLTQ4Nyw0ICs0ODcsMzEgQEAgc3RhdGljIGlubGluZSBp
bnQgbmZzZDRfaXNfanVuY3Rpb24oc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCiAjZW5kaWYgLyog
Q09ORklHX05GU0RfVjQgKi8KIAorLyogYnRyZnMgc3Vidm9sIHN1cHBvcnQgKi8KKy8qCisgKiBz
YW1lIGxvZ2ljYWwgYXMgZnMvYnRyZnMgaXNfc3Vidm9sdW1lX2lub2RlKHN0cnVjdCBpbm9kZSAq
aW5vZGUpCisgKiAjZGVmaW5lIEJUUkZTX0ZJUlNUX0ZSRUVfT0JKRUNUSUQgMjU2VUxMCisgKiAj
ZGVmaW5lIEJUUkZTX1NVUEVSX01BR0lDICAgICAgIDB4OTEyMzY4M0UKKyAqLworc3RhdGljIGlu
bGluZSBib29sIGRfaXNfYnRyZnNfc3Vidm9sKGNvbnN0IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkK
K3sKKyAgICBib29sIHJldCA9IGRlbnRyeS0+ZF9pbm9kZSAmJiB1bmxpa2VseShkZW50cnktPmRf
aW5vZGUtPmlfaW5vID09IDI1NlVMTCkgJiYKKwkJZGVudHJ5LT5kX3NiICYmIGRlbnRyeS0+ZF9z
Yi0+c19tYWdpYyA9PSBCVFJGU19TVVBFUl9NQUdJQzsKKwkvL3ByaW50ayhLRVJOX0lORk8gImRf
aXNfYnRyZnNfc3Vidm9sKCVzKT0lZFxuIiwgZGVudHJ5LT5kX25hbWUubmFtZSwgcmV0KTsKKwly
ZXR1cm4gcmV0OworfQorI2luY2x1ZGUgPGxpbnV4L25hbWVpLmg+CisvKiBhZGQgYnRyZnMgc3Vi
dm9sIHN1cHBvcnQgdGhhdCBvbmx5IHVzZWQgaW4gbmZzZCAqLworc3RhdGljIGlubGluZSBpbnQg
bmZzZF9mb2xsb3dfZG93bihzdHJ1Y3QgcGF0aCAqcGF0aCkKK3sKKwlyZXR1cm4gZm9sbG93X2Rv
d24ocGF0aCk7Cit9CisvKiBhZGQgYnRyZnMgc3Vidm9sIHN1cHBvcnQgdGhhdCBvbmx5IHVzZWQg
aW4gbmZzZCAqLworc3RhdGljIGlubGluZSBpbnQgbmZzZF9mb2xsb3dfdXAoc3RydWN0IHBhdGgg
KnBhdGgpCit7CisJaWYodW5saWtlbHkoZF9pc19idHJmc19zdWJ2b2wocGF0aC0+ZGVudHJ5KSkp
CisJCXJldHVybiAwOworCXJldHVybiBmb2xsb3dfdXAocGF0aCk7Cit9CisKICNlbmRpZiAvKiBM
SU5VWF9ORlNEX05GU0RfSCAqLwpkaWZmIC0tZ2l0IGEvZnMvbmZzZC92ZnMuYyBiL2ZzL25mc2Qv
dmZzLmMKaW5kZXggMWVjYWNlZS4uM2FiOWI3ZiAxMDA2NDQKLS0tIGEvZnMvbmZzZC92ZnMuYwor
KysgYi9mcy9uZnNkL3Zmcy5jCkBAIC02NSw5ICs2NSwxMyBAQCBuZnNkX2Nyb3NzX21udChzdHJ1
Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QgZGVudHJ5ICoqZHBwLAogCQkJICAgIC5kZW50cnkg
PSBkZ2V0KGRlbnRyeSl9OwogCWludCBlcnIgPSAwOwogCi0JZXJyID0gZm9sbG93X2Rvd24oJnBh
dGgpOworCWVyciA9IG5mc2RfZm9sbG93X2Rvd24oJnBhdGgpOwogCWlmIChlcnIgPCAwKQogCQln
b3RvIG91dDsKKwlpZiAodW5saWtlbHkoZF9pc19idHJmc19zdWJ2b2woZGVudHJ5KSkpeworCQlw
YXRoX3B1dCgmcGF0aCk7CisJCWdvdG8gb3V0OworCX0gZWxzZQogCWlmIChwYXRoLm1udCA9PSBl
eHAtPmV4X3BhdGgubW50ICYmIHBhdGguZGVudHJ5ID09IGRlbnRyeSAmJgogCSAgICBuZnNkX21v
dW50cG9pbnQoZGVudHJ5LCBleHApID09IDIpIHsKIAkJLyogVGhpcyBpcyBvbmx5IGEgbW91bnRw
b2ludCBpbiBzb21lIG90aGVyIG5hbWVzcGFjZSAqLwpAQCAtMTE0LDcgKzExOCw3IEBAIHN0YXRp
YyB2b2lkIGZvbGxvd190b19wYXJlbnQoc3RydWN0IHBhdGggKnBhdGgpCiB7CiAJc3RydWN0IGRl
bnRyeSAqZHA7CiAKLQl3aGlsZSAocGF0aC0+ZGVudHJ5ID09IHBhdGgtPm1udC0+bW50X3Jvb3Qg
JiYgZm9sbG93X3VwKHBhdGgpKQorCXdoaWxlIChwYXRoLT5kZW50cnkgPT0gcGF0aC0+bW50LT5t
bnRfcm9vdCAmJiBuZnNkX2ZvbGxvd191cChwYXRoKSkKIAkJOwogCWRwID0gZGdldF9wYXJlbnQo
cGF0aC0+ZGVudHJ5KTsKIAlkcHV0KHBhdGgtPmRlbnRyeSk7CkBAIC0xNjAsNiArMTY0LDggQEAg
aW50IG5mc2RfbW91bnRwb2ludChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBzdmNfZXhw
b3J0ICpleHApCiAJCXJldHVybiAxOwogCWlmIChuZnNkNF9pc19qdW5jdGlvbihkZW50cnkpKQog
CQlyZXR1cm4gMTsKKwlpZiAoZF9pc19idHJmc19zdWJ2b2woZGVudHJ5KSkKKwkJcmV0dXJuIDE7
CiAJaWYgKGRfbW91bnRwb2ludChkZW50cnkpKQogCQkvKgogCQkgKiBNaWdodCBvbmx5IGJlIGEg
bW91bnRwb2ludCBpbiBhIGRpZmZlcmVudCBuYW1lc3BhY2UsCi0tIAoyLjMwLjIKCg==
--------_60D155E100000000DAE9_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="0002-trace-nfsd-btrfs-subvol-support.txt"
Content-Disposition: attachment;
 filename="0002-trace-nfsd-btrfs-subvol-support.txt"
Content-Transfer-Encoding: base64

RnJvbSA2Mzk0ODlhNjBiODRmOWQxNjk1NTE0M2Y1MmZjNjMxNjIwNWFjNTdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB3YW5neXVndWkgPHdhbmd5dWd1aUBlMTYtdGVjaC5jb20+CkRh
dGU6IFRodSwgMTcgSnVuIDIwMjEgMDg6MzM6MDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSB0cmFj
ZSBuZnNkOiBidHJmcyBzdWJ2b2wgc3VwcG9ydAoKWyAgMjM1LjgzMTEzNl0gc2V0X3ZlcnNpb25f
YW5kX2ZzaWRfdHlwZSBmc2lkX3R5cGU9NwpbICAyMzUuODQyNDgzXSBuZnNkX2Nyb3NzX21udCh0
ZXN0KT0wClsgIDIzNS44NDU4ODJdIG5mc2Q6IG5mc2RfbG9va3VwKGZoIDI4OiAwMDA3MDAwMSAw
MDQ0MDAwMSAwMDAwMDAwMCA3M2ZiNGIwYSAzMTU5NmIyZSA3YmU5Nzg5YiwgdGVzdCk9LwpbICAy
MzUuODU0OTAyXSBzZXRfdmVyc2lvbl9hbmRfZnNpZF90eXBlIGZzaWRfdHlwZT02ClsgIDIzNS44
NTk2ODZdIG5mc19kX2F1dG9tb3VudCh0ZXN0KQpbICAyMzUuODYzMDY5XSBuZnNkX2Nyb3NzX21u
dCh0ZXN0KT0wClsgIDIzNS44NjY0NzhdIG5mc2Q6IG5mc2RfbG9va3VwKGZoIDI4OiAwMDA3MDAw
MSAwMDQ0MDAwMSAwMDAwMDAwMCA3M2ZiNGIwYSAzMTU5NmIyZSA3YmU5Nzg5YiwgdGVzdCk9Lwpb
ICAyMzUuODc1NTAwXSBzZXRfdmVyc2lvbl9hbmRfZnNpZF90eXBlIGZzaWRfdHlwZT02ClsgIDIz
OS4yMDQ2NzddIGxvb2t1cF9wb3NpdGl2ZV91bmxvY2tlZChuYW1lPXhmczIpIGRlbnRyeT14ZnMy
ClsgIDIzOS4yMTAzMTFdIG5mc2RfY3Jvc3NfbW50KHhmczIpPTAKWyAgMjM5LjIxMzcwOF0gc2V0
X3ZlcnNpb25fYW5kX2ZzaWRfdHlwZSBmc2lkX3R5cGU9NgpbICAyMzkuMjE4NDA2XSBuZnNkNF9l
bmNvZGVfZGlyZW50X2ZhdHRyKC8pIEZBVFRSNF9XT1JEMF9GU0lEPTEgIEZBVFRSNF9XT1JEMV9N
T1VOVEVEX09OX0ZJTEVJRD0xCgl3aHkgLz8KWyAgMjM5LjIyNzA3OF0gbmZzX2RfYXV0b21vdW50
KHhmczIpCgl3aHk/ClsgIDIzOS4yMzA0MzddIG5mc2RfY3Jvc3NfbW50KHhmczIpPTAKWyAgMjM5
LjIzMzgzOF0gbmZzZDogbmZzZF9sb29rdXAoZmggMjA6IDAwMDYwMDAxIDJiMDMxZjdkIGMyNDlm
ZGQwIDFhYTg0YjhlIDA0NWQ3NzRhIDAwMDAwMDAwLCB4ZnMyKT0vClsgIDIzOS4yNDI4NTRdIHNl
dF92ZXJzaW9uX2FuZF9mc2lkX3R5cGUgZnNpZF90eXBlPTYKClsgIDM3My4zMzIxMjRdIHNldF92
ZXJzaW9uX2FuZF9mc2lkX3R5cGUgZnNpZF90eXBlPTcKWyAgMzczLjMzNzYzOV0gbmZzZF9jcm9z
c19tbnQodGVzdCk9MApbICAzNzMuMzQxMDM1XSBuZnNkOiBuZnNkX2xvb2t1cChmaCAyODogMDAw
NzAwMDEgMDA0NDAwMDEgMDAwMDAwMDAgNzNmYjRiMGEgMzE1OTZiMmUgN2JlOTc4OWIsIHRlc3Qp
PS8KWyAgMzczLjM1MDA0N10gc2V0X3ZlcnNpb25fYW5kX2ZzaWRfdHlwZSBmc2lkX3R5cGU9Ngpb
ICAzNzMuMzU0NzgxXSBuZnNfZF9hdXRvbW91bnQodGVzdCkKWyAgMzczLjM1ODEyNV0gbmZzZF9j
cm9zc19tbnQodGVzdCk9MApbICAzNzMuMzYxNTI0XSBuZnNkOiBuZnNkX2xvb2t1cChmaCAyODog
MDAwNzAwMDEgMDA0NDAwMDEgMDAwMDAwMDAgNzNmYjRiMGEgMzE1OTZiMmUgN2JlOTc4OWIsIHRl
c3QpPS8KWyAgMzczLjM3MDUzN10gc2V0X3ZlcnNpb25fYW5kX2ZzaWRfdHlwZSBmc2lkX3R5cGU9
NgpbICAzNzcuNTIxOTA4XSBsb29rdXBfcG9zaXRpdmVfdW5sb2NrZWQobmFtZT1zdWIxKSBkZW50
cnk9c3ViMQpbICAzNzcuNTI3NDc3XSBuZnNkX2Nyb3NzX21udChzdWIxKT0wClsgIDM3Ny41MzA4
NzldIHNldF92ZXJzaW9uX2FuZF9mc2lkX3R5cGUgZnNpZF90eXBlPTYKWyAgMzc3LjUzNTU3Ml0g
bmZzZDRfZW5jb2RlX2RpcmVudF9mYXR0cihzdWIxKSBGQVRUUjRfV09SRDBfRlNJRD0xICBGQVRU
UjRfV09SRDFfTU9VTlRFRF9PTl9GSUxFSUQ9MQpbICAzNzcuNTQ0NDIwXSBsb29rdXBfcG9zaXRp
dmVfdW5sb2NrZWQobmFtZT0uc25hcHNob3QpIGRlbnRyeT0uc25hcHNob3QKCmJ0cmZzIHN1YnZv
bHMgPT5mb3JjZSBjcm9zc21udAoJc3Vidm9sIG5mcy91bW91bnQ6IG9zIHNodXRkb253IG9yIG1h
bnVhbCBuZnMvdW1vdW50PwoJCXNwZWNpYWwgc3RhdHVzKEJUUkZTX0xBU1RfRlJFRV9PQkpFQ1RJ
RCxvbmx5IHJldHVybiB0byBuZnMpPwoJCSNkZWZpbmUgQlRSRlNfTEFTVF9GUkVFX09CSkVDVElE
IC0yNTZVTEwKCQkoc3RydWN0IGZpbGUgKS0+KHN0cnVjdCBpbm9kZSAqZl9pbm9kZSktPihzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKmlfc2I7KS0+KHVuc2lnbmVkIGxvbmcgc19tYWdpYykKYnRyZnMtPnhm
cwk9PnN0aWxsIG5lZWQgY3Jvc3NtbnQKeGZzLT5idHJmcwk9PnN0aWxsIG5lZWQgY3Jvc3NtbnQK
Ck5GU0VYUF9DUk9TU01PVU5UCk5GU0RfSlVOQ1RJT05fWEFUVFJfTkFNRQpBVF9OT19BVVRPTU9V
TlQKTkZTX0FUVFJfRkFUVFJfTU9VTlRQT0lOVApTX0FVVE9NT1VOVAotLS0KIGZzL25mcy9kaXIu
YyAgICAgICB8IDIgKysKIGZzL25mcy9uYW1lc3BhY2UuYyB8IDEgKwogZnMvbmZzZC9uZnM0eGRy
LmMgIHwgNSArKysrKwogZnMvbmZzZC9uZnNmaC5jICAgIHwgMSArCiBmcy9uZnNkL3Zmcy5jICAg
ICAgfCA1ICsrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMKaW5kZXggYzgzNzY3NS4uOTc1NDQwZCAx
MDA2NDQKLS0tIGEvZnMvbmZzL2Rpci5jCisrKyBiL2ZzL25mcy9kaXIuYwpAQCAtMTc5OSw2ICsx
Nzk5LDggQEAgbmZzNF9kb19sb29rdXBfcmV2YWxpZGF0ZShzdHJ1Y3QgaW5vZGUgKmRpciwgc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LAogCiAJaWYgKCEoZmxhZ3MgJiBMT09LVVBfT1BFTikgfHwgKGZs
YWdzICYgTE9PS1VQX0RJUkVDVE9SWSkpCiAJCWdvdG8gZnVsbF9yZXZhbDsKKwlpZiAoZGVudHJ5
LT5kX2lub2RlICYmIGRlbnRyeS0+ZF9pbm9kZS0+aV9pbm8gPT0gMjU2VUxMICYmIGRlbnRyeS0+
ZF9zYikKKwkJcHJpbnRrKEtFUk5fSU5GTyAibmZzNF9kb19sb29rdXBfcmV2YWxpZGF0ZSglcyk9
JWx4XG4iLCBkZW50cnktPmRfbmFtZS5uYW1lLCBkZW50cnktPmRfc2ItPnNfbWFnaWMpOwogCWlm
IChkX21vdW50cG9pbnQoZGVudHJ5KSkKIAkJZ290byBmdWxsX3JldmFsOwogCmRpZmYgLS1naXQg
YS9mcy9uZnMvbmFtZXNwYWNlLmMgYi9mcy9uZnMvbmFtZXNwYWNlLmMKaW5kZXggMmJjYmUzOC4u
ZjY5NzE1YyAxMDA2NDQKLS0tIGEvZnMvbmZzL25hbWVzcGFjZS5jCisrKyBiL2ZzL25mcy9uYW1l
c3BhY2UuYwpAQCAtMTUyLDYgKzE1Miw3IEBAIHN0cnVjdCB2ZnNtb3VudCAqbmZzX2RfYXV0b21v
dW50KHN0cnVjdCBwYXRoICpwYXRoKQogCWludCB0aW1lb3V0ID0gUkVBRF9PTkNFKG5mc19tb3Vu
dHBvaW50X2V4cGlyeV90aW1lb3V0KTsKIAlpbnQgcmV0OwogCisJcHJpbnRrKEtFUk5fSU5GTyAi
bmZzX2RfYXV0b21vdW50KCVzKVxuIiwgcGF0aC0+ZGVudHJ5LT5kX25hbWUubmFtZSk7CiAJaWYg
KElTX1JPT1QocGF0aC0+ZGVudHJ5KSkKIAkJcmV0dXJuIEVSUl9QVFIoLUVTVEFMRSk7CiAKZGlm
ZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHhkci5jIGIvZnMvbmZzZC9uZnM0eGRyLmMKaW5kZXggNjI1
NWIwNi4uMjU3ZWUxNyAxMDA2NDQKLS0tIGEvZnMvbmZzZC9uZnM0eGRyLmMKKysrIGIvZnMvbmZz
ZC9uZnM0eGRyLmMKQEAgLTMzMDcsNiArMzMwNyw3IEBAIG5mc2Q0X2VuY29kZV9kaXJlbnRfZmF0
dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IG5mc2Q0X3JlYWRkaXIgKmNkLAogCWRl
bnRyeSA9IGxvb2t1cF9wb3NpdGl2ZV91bmxvY2tlZChuYW1lLCBjZC0+cmRfZmhwLT5maF9kZW50
cnksIG5hbWxlbik7CiAJaWYgKElTX0VSUihkZW50cnkpKQogCQlyZXR1cm4gbmZzZXJybm8oUFRS
X0VSUihkZW50cnkpKTsKKwlwcmludGsoS0VSTl9JTkZPICJsb29rdXBfcG9zaXRpdmVfdW5sb2Nr
ZWQobmFtZT0lcykgZGVudHJ5PSVzXG4iLCBuYW1lLCBkZW50cnktPmRfbmFtZS5uYW1lKTsKIAog
CWV4cF9nZXQoZXhwKTsKIAkvKgpAQCAtMzM0NSw2ICszMzQ2LDEwIEBAIG5mc2Q0X2VuY29kZV9k
aXJlbnRfZmF0dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IG5mc2Q0X3JlYWRkaXIg
KmNkLAogb3V0X3B1dDoKIAlkcHV0KGRlbnRyeSk7CiAJZXhwX3B1dChleHApOworCXByaW50ayhL
RVJOX0lORk8gIm5mc2Q0X2VuY29kZV9kaXJlbnRfZmF0dHIoJXMpIEZBVFRSNF9XT1JEMF9GU0lE
PSVkICBGQVRUUjRfV09SRDFfTU9VTlRFRF9PTl9GSUxFSUQ9JWRcbiIsCisJCSBkZW50cnktPmRf
bmFtZS5uYW1lLAorCQkgISEoY2QtPnJkX2JtdmFsWzBdJkZBVFRSNF9XT1JEMF9GU0lEKSwKKwkJ
ISEoY2QtPnJkX2JtdmFsWzFdJkZBVFRSNF9XT1JEMV9NT1VOVEVEX09OX0ZJTEVJRCkpOwogCXJl
dHVybiBuZnNlcnI7CiB9CiAKZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzZmguYyBiL2ZzL25mc2Qv
bmZzZmguYwppbmRleCBjODFkYmJhLi4yOGVhZWEzIDEwMDY0NAotLS0gYS9mcy9uZnNkL25mc2Zo
LmMKKysrIGIvZnMvbmZzZC9uZnNmaC5jCkBAIC01MzAsNiArNTMwLDcgQEAgc3RhdGljIHZvaWQg
c2V0X3ZlcnNpb25fYW5kX2ZzaWRfdHlwZShzdHJ1Y3Qgc3ZjX2ZoICpmaHAsIHN0cnVjdCBzdmNf
ZXhwb3J0ICpleHAKIAlmaHAtPmZoX2hhbmRsZS5maF92ZXJzaW9uID0gdmVyc2lvbjsKIAlpZiAo
dmVyc2lvbikKIAkJZmhwLT5maF9oYW5kbGUuZmhfZnNpZF90eXBlID0gZnNpZF90eXBlOworCXBy
aW50ayhLRVJOX0lORk8gInNldF92ZXJzaW9uX2FuZF9mc2lkX3R5cGUgZnNpZF90eXBlPSVkXG4i
LCBmc2lkX3R5cGUpOwogfQogCiBfX2JlMzIKZGlmZiAtLWdpdCBhL2ZzL25mc2QvdmZzLmMgYi9m
cy9uZnNkL3Zmcy5jCmluZGV4IGFlMzRmZmMuLjZjNTUwMTAgMTAwNjQ0Ci0tLSBhL2ZzL25mc2Qv
dmZzLmMKKysrIGIvZnMvbmZzZC92ZnMuYwpAQCAtNjYsNiArNjYsOCBAQCBuZnNkX2Nyb3NzX21u
dChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QgZGVudHJ5ICoqZHBwLAogCWludCBlcnIg
PSAwOwogCiAJZXJyID0gbmZzZF9mb2xsb3dfZG93bigmcGF0aCk7CisJcHJpbnRrKEtFUk5fSU5G
TyAiZm9sbG93X2Rvd24oKT0lZCBwYXRoLm1udD0lcyBwYXRoLmRlbnRyeT0lc1xuIiwgZXJyLAor
CQlwYXRoLm1udC0+bW50X3Jvb3QtPmRfbmFtZS5uYW1lLCBwYXRoLmRlbnRyeS0+ZF9uYW1lLm5h
bWUpOwogCWlmIChlcnIgPCAwKQogCQlnb3RvIG91dDsKIAlpZiAodW5saWtlbHkoZF9pc19idHJm
c19zdWJ2b2woZGVudHJ5KSkpewpAQCAtMTExLDYgKzExMyw3IEBAIG5mc2RfY3Jvc3NfbW50KHN0
cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBkZW50cnkgKipkcHAsCiAJcGF0aF9wdXQoJnBh
dGgpOwogCWV4cF9wdXQoZXhwMik7CiBvdXQ6CisJcHJpbnRrKEtFUk5fSU5GTyAibmZzZF9jcm9z
c19tbnQoJXMpPSVkXG4iLCBkZW50cnktPmRfbmFtZS5uYW1lLCBlcnIpOwogCXJldHVybiBlcnI7
CiB9CiAKQEAgLTIzMyw5ICsyMzYsMTEgQEAgbmZzZF9sb29rdXBfZGVudHJ5KHN0cnVjdCBzdmNf
cnFzdCAqcnFzdHAsIHN0cnVjdCBzdmNfZmggKmZocCwKIAl9CiAJKmRlbnRyeV9yZXQgPSBkZW50
cnk7CiAJKmV4cF9yZXQgPSBleHA7CisJLy8gcHJpbnRrKEtFUk5fSU5GTyAibmZzZDogbmZzZF9s
b29rdXAoZmggJXMsICUuKnMpPSVzXG4iLCBTVkNGSF9mbXQoZmhwKSwgbGVuLCBuYW1lLCBkZW50
cnktPmRfbmFtZS5uYW1lKTsKIAlyZXR1cm4gMDsKIAogb3V0X25mc2VycjoKKwkvLyBwcmludGso
S0VSTl9JTkZPICJuZnNkOiBuZnNkX2xvb2t1cChmaCAlcywgJS4qcykgZXJyb3JcbiIsIFNWQ0ZI
X2ZtdChmaHApLCBsZW4sIG5hbWUpOwogCWV4cF9wdXQoZXhwKTsKIAlyZXR1cm4gbmZzZXJybm8o
aG9zdF9lcnIpOwogfQotLSAKMi4zMC4yCgo=
--------_60D155E100000000DAE9_MULTIPART_MIXED_--

