Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FCD57625F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiGONBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGONBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 09:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF014D0F
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 06:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F00E62392
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 13:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA20C34115;
        Fri, 15 Jul 2022 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657890105;
        bh=LYOcx9m7U/PfiJ/qmtfKY+e+p9O8qKw7LyzFiu640h8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vn5mfM6paM7kOhbrWk8nA77Xd4E6a/cTXj5VHJXNAJi7fAzDKL87T4wng72S7NeJ4
         ah9m+5SawiM8PH96eteaxPYC2260LZb0dONyT2SXEB7nqWdB3vJgjnQ0IY+yDvNVxx
         tqDOCzP4TMjCM80SXOkbpXc7Hi/liRRPgPZrZt/5e/Abok0S/GyX9XRgbpSQae229H
         dtCBST7h5SbjZQV07iaTFrnSqYhqfTJLrI/rX5Lpii0mbq6zOSi8dQdEGzvaNzWrfc
         bB7MkbRtcybkFHrSKqaz/vxzabLZZeECedcJDKX3XlJJ02xNqyY4jgVZXt1XeG2usd
         RxAn4Fp1M3ghQ==
Message-ID: <8740381aaa51128446734b9854af01bb2c81215b.camel@kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 15 Jul 2022 09:01:44 -0400
In-Reply-To: <165785256143.25184.15897431161933266918@noble.neil.brown.name>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
        , <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
        , <165759318889.25184.8939985512802350340@noble.neil.brown.name>
        , <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
        , <165768676476.25184.1334928545636067316@noble.neil.brown.name>
        , <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
         <165785256143.25184.15897431161933266918@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-15 at 12:36 +1000, NeilBrown wrote:
> On Thu, 14 Jul 2022, Chuck Lever III wrote:
> >=20
> > > On Jul 13, 2022, at 12:32 AM, NeilBrown <neilb@suse.de> wrote:
> > >=20
> > > On Wed, 13 Jul 2022, Chuck Lever III wrote:
> > > >=20
> > > > > On Jul 11, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
> > > > >=20
> > > > > On Thu, 07 Jul 2022, Chuck Lever III wrote:
> > > > > >=20
> > > > > > > On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
> > > > > > >=20
> > > > > > > This series prepares NFSD to be able to adjust to work with a=
 proposed
> > > > > > > patch which allows updates to directories to happen in parall=
el.
> > > > > > > This patch set changes the way directories are locked, so the=
 present
> > > > > > > series cleans up some locking in nfsd.
> > > > > > >=20
> > > > > > > Specifically we remove fh_lock() and fh_unlock().
> > > > > > > These functions are problematic for a few reasons.
> > > > > > > - they are deliberately idempotent - setting or clearing a fl=
ag
> > > > > > > so that a second call does nothing. This makes locking errors=
 harder,
> > > > > > > but it results in code that looks wrong ... and maybe sometim=
es is a
> > > > > > > little bit wrong.
> > > > > > > Early patches clean up several places where this idempotent n=
ature of
> > > > > > > the functions is depended on, and so makes the code clearer.
> > > > > > >=20
> > > > > > > - they transparently call fh_fill_pre/post_attrs(), including=
 at times
> > > > > > > when this is not necessary. Having the calls only when necess=
ary is
> > > > > > > marginally more efficient, and arguably makes the code cleare=
r.
> > > > > > >=20
> > > > > > > nfsd_lookup() currently always locks the directory, though of=
ten no lock
> > > > > > > is needed. So a patch in this series reduces this locking.
> > > > > > >=20
> > > > > > > There is an awkward case that could still be further improved=
.
> > > > > > > NFSv4 open needs to ensure the file is not renamed (or unlink=
ed etc)
> > > > > > > between the moment when the open succeeds, and a later moment=
 when a
> > > > > > > "lease" is attached to support a delegation. The handling of =
this lock
> > > > > > > is currently untidy, particularly when creating a file.
> > > > > > > It would probably be better to take a lease immediately after
> > > > > > > opening the file, and then discarding if after deciding not t=
o provide a
> > > > > > > delegation.
> > > > > > >=20
> > > > > > > I have run fstests and cthon tests on this, but I wouldn't be=
 surprised
> > > > > > > if there is a corner case that I've missed.
> > > > > >=20
> > > > > > Hi Neil, thanks for (re)posting.
> > > > > >=20
> > > > > > Let me make a few general comments here before I send out speci=
fic
> > > > > > review nits.
> > > > > >=20
> > > > > > I'm concerned mostly with how this series can be adequately tes=
ted.
> > > > > > The two particular areas I'm worried about:
> > > > > >=20
> > > > > > - There are some changes to NFSv2 code, which is effectively
> > > > > > fallow. I think I can run v2 tests, once we decide what tests
> > > > > > should be run.
> > > > >=20
> > > > > I hope we can still test v2... I know it is disabled by default..
> > > > > If we can't test it, we should consider removing it.
> > > >=20
> > > > The work of deprecating and removing NFSv2 is already under way.
> > > > I think what I'm asking is if /you/ have tested the NFSv2 changes.
> > >=20
> > > That's a question I can answer. I haven't. I will.
> >=20
> > Just in case it's not clear by now, NFSv2 (and NFSv3)
> > stability is the reason I don't want to perturb the
> > NFSD VFS API code in any significant way unless it's
> > absolutely needed.
>=20
> "absolutely" seems like a rather high bar.  It makes the goal of
> "stability" seem more like "ossification".
> Certainly we don't want to break things.  Equally certainly we will.
> I don't think "hold back useful changes out of fear" is the path to
> success.  Testing, review, and responding to bug reports is what we find
> works best - and what we generally do.
>=20
> And I wouldn't class NFSv3 at all with NFSv2 (not even in parentheses).
> NFSv2 has very few (if any) users in the broad community, so bugs are
> likely to go unnoticed for extended periods.  NFSv3 is, I believe, still
> widely used, though not as widely as v4.  There are use-cases where I
> would recommend v3.
>=20
> e.g.  a case could certainly be made to not extend my directory-locking
> changes to v2-specific code, but v3 should get them.
>=20
> >=20
> >=20
> > > > > > Secondarily, the series adds more bells and whistles to the gen=
eric
> > > > > > NFSD VFS APIs on behalf of NFSv4-specific requirements. In part=
icular:
> > > > > >=20
> > > > > > - ("NFSD: change nfsd_create() to unlock directory before retur=
ning.")
> > > > > > makes some big changes to nfsd_create(). But that helper itself
> > > > > > is pretty small. Seems like cleaner code would result if NFSv4
> > > > > > had its own version of nfsd_create() to deal with the post-chan=
ge
> > > > > > cases.
> > > > >=20
> > > > > I would not like that approach. Duplicating code is rarely a good=
 idea.
> > > >=20
> > > > De-duplicating code /can/ be a good idea, but isn't always a good
> > > > idea. If the exceptional cases add a lot of logic, that can make th=
e
> > > > de-duplicated code difficult to read and reason about, and it can
> > > > make it brittle, just as it does in this case. Modifications on
> > > > behalf of NFSv4 in this common piece of code is possibly hazardous
> > > > to NFSv3, and navigating around the exception logic makes it
> > > > difficult to understand and review.
> > >=20
> > > Are we looking at the same code?
> > > The sum total of extra code needed for v4 is:
> > > - two extra parameters:
> > > 	 void (*post_create)(struct svc_fh *fh, void *data),
> > > 	 void *data)
> > > - two lines of code:
> > > 	if (!err && post_create)
> > > 		post_create(resfhp, data);
> > >=20
> > > does that really make anything hard to follow?
> >=20
> > The synopsis of nfsd_create() is already pretty cluttered.
>=20
> Would it help to collect related details (name, type, attributes, acl,
> label) into a struct and pass a reference to that around?
> One awkwardness in my latest patch is that the acl and label are not set
> in nfsd_create_setattr().  If they were passed around together with the
> attributes, that would be a lot easier to achieve.
>=20
> >=20
> > You're adding that extra code in nfsd_symlink() too IIRC? And,
> > this change adds a virtual function call (which has significant
> > overhead these days) for reasons of convenience rather than
> > necessity.
>=20
> "significant"?  In context of creation a file, I don't think one more
> virtual function call is all that significant?
>=20
> I started writing code to avoid the function pointer, but the function
> args list exploded.  If you could be happy with e.g.  a struct
> nfs_create_args which contains attrs, acl, label, and was passed into
> nfsd_create_setattr(), then I think that would cleanly avoid the desire
> for a function pointer.
>=20
> >=20
> >=20
> > > > IMO code duplication is not an appropriate design pattern in this
> > > > specific instance.
> > >=20
> > > I'm guessing there is a missing negation in there.
> >=20
> > Yes, thanks.
> >=20
> >=20
> > > > > Maybe, rather than passing a function and void* to nfsd_create(),=
 we
> > > > > could pass an acl and a label and do the setting in vfs.c rather =
then
> > > > > nfs4proc.c. The difficult part of that approach is getting back t=
he
> > > > > individual error statuses. That should be solvable though.
> > > >=20
> > > > The bulk of the work in nfsd_create() is done by lookup_one_len()
> > > > and nfsd_create_locked(), both of which are public APIs. The rest
> > > > of nfsd_create() is code that appears in several other places
> > > > already.
> > >=20
> > > "several" =3D=3D 1. The only other call site for nfsd_create_locked()=
 is in
> > > nfsd_proc_create()
> >=20
> > But there are 15 call sites under fs/nfsd/ for lookup_one_len().
> > It's a pretty common trope.
> >=20
> >=20
> > > I would say that the "bulk" of the work is the interplay between
> > > locking, error checking, and these two functions you mention.
> >=20
> > You're looking at the details of your particular change, and
> > I'm concerned about how much technical debt is going to
> > continue to accrue in an area shared with legacy protocol
> > implementation.
> >=20
> > I'm still asking myself if I can live with the extra parameters
> > and virtual function call. Maybe. IMO, there are three ways
> > forward:
> >=20
> > 1. I can merge your patch and move on.
> > 2. I can merge your patch as it is and follow up with clean-up.
> > 3. I can drop your patch and write it the way I prefer.
> >=20
> >=20
> > > > > > - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue=
:
> > > > > > nfsd_lookup() is being changed such that its semantics are
> > > > > > substantially different for NFSv4 than for others. This is
> > > > > > possibly an indication that nfsd_lookup() should also be
> > > > > > duplicated into the NFSv4-specific code and the generic VFS
> > > > > > version should be left alone.
> > > > >=20
> > > > > Again, I don't like duplication. In this case, I think the longer=
 term
> > > > > solution is to remove the NFSv4 specific locking differences and =
solve
> > > > > the problem differently. i.e. don't hold the inode locked, but ch=
eck
> > > > > for any possible rename after getting a lease. Once that is done,
> > > > > nfsd_lookup() can have saner semantics.
> > > >=20
> > > > Then, perhaps we should bite that bullet and do that work now.
> > >=20
> > > While this does have an appeal, it also looks like the start of a rab=
bit
> > > hole where I find have to fix up a growing collection of problems bef=
ore
> > > my patch can land.
> >=20
> > That's kind of the nature of the beast.
> >=20
> > You are requesting changes that add technical debt with the
> > promise that "sometime in the future" that debt will be
> > erased. Meanwhile, nfsd_lookup() will be made harder to
> > maintain, and it will continue to contain a real bug.
> >=20
> > I'm saying if there's a real bug here, addressing that should
> > be the priority.
> >=20
> >=20
> > > I think balance is needed - certainly asking for some preliminary
> > > cleanup is appropriate. Expecting long standing and subtle issues tha=
t
> > > are tangential to the main goal to be resolved first is possibly aski=
ng
> > > too much.
> >=20
> > Fixing the bug seems to me (perhaps naively) to be directly
> > related to the parallelism of directory operations. Why do
> > you think it is tangential?
> >=20
>=20
> The bug was exposed by the analysis required for the changes I want, but
> I think that is as close as the connection goes.
> To really see if it is tangential, we would need to come up with a
> solution and see how easily it is ported across my patches.
>=20
> As I said in a reply to Jeff, I don't think locking of the parent
> directory should be part of the solution.  After getting a lease, we
> repeat the lookup and see if dentry has changed.  After my patches, that
> would mean calling lookup_one_len_unlocked().  Before my patches, it
> would mean calling fh_unlock() earlier to ensure the directory is no
> longer locked but still calling lookup_one_len_unlocked()
>=20
>=20
> > Asking for bugs to be addressed before new features go in
> > seems sensible to me, and is a common practice to enable the
> > resulting fixes to be backported. If you don't want to address
> > the bug you mentioned, then someone else will need to, and
> > that's fine. I think the priority should be bug fixes first.
>=20
> As a general principle I would agree.
> In this case the bug is minor, long standing, and tangential.
> And the series imposes enough review burden as it is.
>=20
> But if Jeff can produce a fix, either to be applied before or after,
> then that would be an excellent solution.
>=20
> Thanks,
> NeilBrown
>=20
>=20


FWIW, I hit this while running fstests against the server with some
draft changes. This crash is not in an area I touched, so I suspect
something in Neil's locking cleanup:

[  434.257242] ------------[ cut here ]------------
[  434.257278] kernel BUG at fs/nfsd/xdr4.h:752!
[  434.257755] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  434.257937] CPU: 2 PID: 1202 Comm: nfsd Kdump: loaded Tainted: G        =
   OE     5.19.0-rc5+ #316
[  434.258179] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.0-3.el9 04/01/201=
4
[  434.258371] RIP: 0010:nfsd4_open+0x1940/0x1a30 [nfsd]
[  434.258615] Code: 40 e8 54 04 e2 e6 48 8b 7c 24 40 41 89 c4 e8 57 7e d4 =
e6 41 f7 d4 4c 8b 44 24 60 66 44 21 63 44 48 8b 54 24 40 e9 46 fc ff ff <0f=
> 0b 48 8d bd 88 00 00 00 e8 72 80 d4 e6 4c 8b ad 88 00 00 00 49
[  434.259053] RSP: 0018:ffff888134897c10 EFLAGS: 00010246
[  434.259211] RAX: 0000000000000000 RBX: ffff8881348791a0 RCX: ffffffffc07=
fbb44
[  434.259408] RDX: 1ffff1102691001a RSI: 0000000000000002 RDI: ffff8881348=
800d1
[  434.259606] RBP: ffff888134880030 R08: 0000000000000000 R09: 00000000000=
00001
[  434.259802] R10: fffffbfff542dfac R11: 0000000000000001 R12: 00000000000=
00000
[  434.260000] R13: ffff888133ab8000 R14: 0000000000000000 R15: ffff8881165=
db400
[  434.260195] FS:  0000000000000000(0000) GS:ffff888225500000(0000) knlGS:=
0000000000000000
[  434.260466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  434.260697] CR2: 0000558890b5d178 CR3: 0000000107844000 CR4: 00000000003=
506e0
[  434.260949] Call Trace:
[  434.261106]  <TASK>
[  434.261260]  ? nfsd4_decode_notsupp+0x10/0x10 [nfsd]
[  434.261549]  ? nfsd4_interssc_connect+0x8e0/0x8e0 [nfsd]
[  434.261858]  ? preempt_count_sub+0x14/0xc0
[  434.262054]  ? percpu_counter_add_batch+0x60/0xd0
[  434.262261]  nfsd4_proc_compound+0x8c6/0xe90 [nfsd]
[  434.262553]  nfsd_dispatch+0x2a9/0x5c0 [nfsd]
[  434.262836]  svc_process_common+0x6ab/0xc30 [sunrpc]
[  434.263162]  ? svc_create_pooled+0x390/0x390 [sunrpc]
[  434.263484]  ? nfsd_svc+0x830/0x830 [nfsd]
[  434.263755]  ? svc_recv+0xabf/0x1310 [sunrpc]
[  434.264074]  svc_process+0x1a3/0x200 [sunrpc]
[  434.264382]  nfsd+0x1d7/0x390 [nfsd]
[  434.264640]  ? nfsd_shutdown_threads+0x200/0x200 [nfsd]
[  434.264926]  kthread+0x167/0x1a0
[  434.265101]  ? kthread_complete_and_exit+0x20/0x20
[  434.265307]  ret_from_fork+0x22/0x30
[  434.265494]  </TASK>
[  434.265652] Modules linked in: rpcsec_gss_krb5(E) nft_fib_inet(E) nft_fi=
b_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) n=
f_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conn=
track(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) rfkill(E) nf_tables(=
E) nfnetlink(E) iTCO_wdt(E) intel_rapl_msr(E) intel_pmc_bxt(E) iTCO_vendor_=
support(E) joydev(E) intel_rapl_common(E) i2c_i801(E) i2c_smbus(E) virtio_b=
alloon(E) lpc_ich(E) nfsd(OE) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) d=
rm(E) fuse(E) sunrpc(E) xfs(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_i=
ntel(E) ghash_clmulni_intel(E) serio_raw(E) virtio_blk(E) virtio_console(E)=
 virtio_net(E) net_failover(E) failover(E) qemu_fw_cfg(E)
[  434.267660] ---[ end trace 0000000000000000 ]---
[  434.267870] RIP: 0010:nfsd4_open+0x1940/0x1a30 [nfsd]
[  434.268161] Code: 40 e8 54 04 e2 e6 48 8b 7c 24 40 41 89 c4 e8 57 7e d4 =
e6 41 f7 d4 4c 8b 44 24 60 66 44 21 63 44 48 8b 54 24 40 e9 46 fc ff ff <0f=
> 0b 48 8d bd 88 00 00 00 e8 72 80 d4 e6 4c 8b ad 88 00 00 00 49
[  434.268771] RSP: 0018:ffff888134897c10 EFLAGS: 00010246
[  434.268995] RAX: 0000000000000000 RBX: ffff8881348791a0 RCX: ffffffffc07=
fbb44
[  434.269247] RDX: 1ffff1102691001a RSI: 0000000000000002 RDI: ffff8881348=
800d1
[  434.269511] RBP: ffff888134880030 R08: 0000000000000000 R09: 00000000000=
00001
[  434.269775] R10: fffffbfff542dfac R11: 0000000000000001 R12: 00000000000=
00000
[  434.270030] R13: ffff888133ab8000 R14: 0000000000000000 R15: ffff8881165=
db400
[  434.270288] FS:  0000000000000000(0000) GS:ffff888225500000(0000) knlGS:=
0000000000000000
[  434.270632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  434.270862] CR2: 0000558890b5d178 CR3: 0000000107844000 CR4: 00000000003=
506e0

faddr2line says:

$ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd4_open+0x1940
nfsd4_open+0x1940/0x1a30:

set_change_info at /home/jlayton/git/linux/fs/nfsd/xdr4.h:752
 747 	#define NFS4_SVC_XDRSIZE		sizeof(struct nfsd4_compoundargs)
 748 =09
 749 	static inline void
 750 	set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 751 	{
>752<		BUG_ON(!fhp->fh_pre_saved);
 753 		cinfo->atomic =3D (u32)(fhp->fh_post_saved && !fhp->fh_no_atomic_att=
r);
 754 =09
 755 		cinfo->before_change =3D fhp->fh_pre_change;
 756 		cinfo->after_change =3D fhp->fh_post_change;
 757 	}

(inlined by) do_open_lookup at /home/jlayton/git/linux/fs/nfsd/nfs4proc.c:5=
02
 497 		accmode =3D NFSD_MAY_NOP;
 498 		if (open->op_created ||
 499 				open->op_claim_type =3D=3D NFS4_OPEN_CLAIM_DELEGATE_CUR)
 500 			accmode |=3D NFSD_MAY_OWNER_OVERRIDE;
 501 		status =3D do_open_permission(rqstp, *resfh, open, accmode);
>502<		set_change_info(&open->op_cinfo, current_fh);
 503 	out:
 504 		if (status)
 505 			inode_unlock(current_fh->fh_dentry->d_inode);
 506 		return status;
 507 	}

(inlined by) nfsd4_open at /home/jlayton/git/linux/fs/nfsd/nfs4proc.c:625
 620 			goto out;
 621 =09
 622 		switch (open->op_claim_type) {
 623 		case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 624 		case NFS4_OPEN_CLAIM_NULL:
>625<			status =3D do_open_lookup(rqstp, cstate, open, &resfh);
 626 			if (status)
 627 				goto out;
 628 			locked =3D true;
 629 			break;
 630 		case NFS4_OPEN_CLAIM_PREVIOUS:

I haven't yet dug down into the actual cause yet.
