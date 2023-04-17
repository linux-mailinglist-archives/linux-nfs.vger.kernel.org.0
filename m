Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80CD6E3D70
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 04:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDQCZn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Apr 2023 22:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDQCZm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Apr 2023 22:25:42 -0400
Received: from out28-80.mail.aliyun.com (out28-80.mail.aliyun.com [115.124.28.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D21FCC
        for <linux-nfs@vger.kernel.org>; Sun, 16 Apr 2023 19:25:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06908055|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0113397-0.000391995-0.988268;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.SHwAW1s_1681698335;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.SHwAW1s_1681698335)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 10:25:36 +0800
Date:   Mon, 17 Apr 2023 10:25:37 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: [PATCH nfs-utils] mountd: don't advertise krb5 for v4root when not configured.
Cc:     "Steve Dickson" <steved@redhat.com>, "Petr Vorel" <pvorel@suse.cz>,
        "linux-nfs" <linux-nfs@vger.kernel.org>,
        "Dave Jones" <davej@codemonkey.org.uk>, bfields@redhat.com
In-Reply-To: <168169801568.24821.12909751358635990715@noble.neil.brown.name>
References: <20230417100511.9131.409509F4@e16-tech.com> <168169801568.24821.12909751358635990715@noble.neil.brown.name>
Message-Id: <20230417102536.FAE6.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> On Mon, 17 Apr 2023, Wang Yugui wrote:
> > Hi,
> > 
> > > 
> > > If /etc/krb5.keytab does not exist, then krb5 cannot work, so
> > > advertising it as an option for v4root is pointless.
> > > Since linux commit 676e4ebd5f2c ("NFSD: SECINFO doesn't handle
> > > unsupported pseudoflavors correctly") this can result in an unhelpful
> > > warning if the krb5 code is not built, or built as a module which is not
> > > installed.
> > > 
> > > [  161.668635] NFS: SECINFO: security flavor 390003 is not supported
> > > [  161.668655] NFS: SECINFO: security flavor 390004 is not supported
> > > [  161.668670] NFS: SECINFO: security flavor 390005 is not supported
> > > 
> > > So avoid advertising krb5 security options when krb5.keytab cannot be
> > > found.
> > > 
> > > Link: https://lore.kernel.org/linux-nfs/20170104190327.v3wbpcbqtfa5jy7d@codemonkey.org.uk/
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  support/export/v4root.c         |  2 ++
> > >  support/include/pseudoflavors.h |  1 +
> > >  support/nfs/exports.c           | 14 +++++++-------
> > >  3 files changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/support/export/v4root.c b/support/export/v4root.c
> > > index fbb0ad5f5b81..3e049582d7c1 100644
> > > --- a/support/export/v4root.c
> > > +++ b/support/export/v4root.c
> > > @@ -66,6 +66,8 @@ set_pseudofs_security(struct exportent *pseudo)
> > >  
> > >  		if (!flav->fnum)
> > >  			continue;
> > > +		if (flav->need_krb5 && !access("/etc/krb5.keytab", F_OK))
> > > +			continue;
> > 
> > Could we replace "/etc/krb5.keytab" with krb5_kt_default_name()?
> 
> Maybe?  Why would we want to?
> 
> The presence of /etc/krb5.keytab is what we already use in a couple of
> systemd unit files to determine if krb5 is configured.  Why not just use
> the same here?

OK to just same as other files.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/04/17


