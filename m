Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2B5894BD
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiHCXVr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Aug 2022 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCXVq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Aug 2022 19:21:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78B2A26E
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 16:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B98B20660;
        Wed,  3 Aug 2022 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659568903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WX3MyHefy1m59oXa4YMmkgiCO4W1byOGHw1BNWRWYEI=;
        b=uIZa5ohSXvr3rXkA1xgYUVbF2vcZvd3y5Fvn3so69YUt2nacp+GL4pJ6X6JAMnMKSIWvfs
        AUUVYQovRvn+aGywU96S/0RZdi0SBaT9hkflf2SbzKxHvcyTYqhfsWRGo5yHpw73VVjIo8
        HSpbq8aFpzkJ6calgR9ImsaCPu3vge4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659568903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WX3MyHefy1m59oXa4YMmkgiCO4W1byOGHw1BNWRWYEI=;
        b=SxumgYHsZ+YPhIiDUI+mGtq7DMy2X13+otzQA5yqcWN78bPcGiHIlpFd9niaoNB9ndCQSm
        F+o2VPbMnyb+rLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB41913AD8;
        Wed,  3 Aug 2022 23:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5R09JQUD62LuYgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 03 Aug 2022 23:21:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "kernel test robot" <lkp@intel.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [linux-next:master 13556/14285] ERROR: modpost: "set_posix_acl"
 [fs/nfsd/nfsd.ko] undefined!
In-reply-to: <AED75B2A-D639-422C-A744-CD40E2490E92@oracle.com>
References: <202208031404.a1NgfSzI-lkp@intel.com>,
 <AED75B2A-D639-422C-A744-CD40E2490E92@oracle.com>
Date:   Thu, 04 Aug 2022 09:21:38 +1000
Message-id: <165956889874.12283.5007966519219519664@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 03 Aug 2022, Chuck Lever III wrote:
>=20
> > On Aug 3, 2022, at 2:55 AM, kernel test robot <lkp@intel.com> wrote:
> >=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master
> > head:   42d670bda02fdba0f3944c92f545984501e5788d
> > commit: 2743f3e0444f7287161ecf3e464ee2733dde412d [13556/14285] NFSD: add =
posix ACLs to struct nfsd_attrs
> > config: parisc-defconfig (https://download.01.org/0day-ci/archive/2022080=
3/202208031404.a1NgfSzI-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=3D1 build):
> >        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin=
/make.cross -O ~/bin/make.cross
> >        chmod +x ~/bin/make.cross
> >        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git/commit/?id=3D2743f3e0444f7287161ecf3e464ee2733dde412d
> >        git remote add linux-next https://git.kernel.org/pub/scm/linux/ker=
nel/git/next/linux-next.git
> >        git fetch --no-tags linux-next master
> >        git checkout 2743f3e0444f7287161ecf3e464ee2733dde412d
> >        # save the config file
> >        mkdir build_dir && cp config build_dir/.config
> >        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cros=
s W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash
> >=20
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >=20
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >=20
> >>> ERROR: modpost: "set_posix_acl" [fs/nfsd/nfsd.ko] undefined!
> >=20
> > --=20
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
>=20
> Neil, I've reproduced this and confirmed that the following addresses
> the error:
>=20
>  464 #ifdef CONFIG_FS_POSIX_ACL
>  465         if (attr->na_pacl)
>  466                 attr->na_aclerr =3D set_posix_acl(&init_user_ns,
>  467                                                 inode, ACL_TYPE_ACCESS,
>  468                                                 attr->na_pacl);
>  469         if (!attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mod=
e))
>  470                 attr->na_aclerr =3D set_posix_acl(&init_user_ns,
>  471                                                 inode, ACL_TYPE_DEFAUL=
T,
>  472                                                 attr->na_dpacl);
>  473 #endif
>=20
> I can squash this change into ("NFSD: add posix ACLs to struct nfsd_attrs").

Thanks. I would prefer a fix like

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8a2731d2969d..eeeadd0b2f13 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -455,11 +455,13 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attr->label && attr->label->len)
 		attr->label_failed =3D security_inode_setsecctx(
 			dentry, attr->label->data, attr->label->len);
-	if (attr->pacl)
+	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
+	    attr->pacl)
 		attr->acl_failed =3D set_posix_acl(&init_user_ns,
 						 inode, ACL_TYPE_ACCESS,
 						 attr->pacl);
-	if (!attr->acl_failed && attr->dpacl && S_ISDIR(inode->i_mode))
+	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
+	    !attr->acl_failed && attr->dpacl && S_ISDIR(inode->i_mode))
 		attr->acl_failed =3D set_posix_acl(&init_user_ns,
 						 inode, ACL_TYPE_DEFAULT,
 						 attr->dpacl);


as that is consistent with similar usage in fs/ksmbd/ and with section
21 "Conditional Compilation' in coding-style.rst

Thanks,
NeilBrown



>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
