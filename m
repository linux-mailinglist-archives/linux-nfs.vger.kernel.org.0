Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422AA592048
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Aug 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiHNO4V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Aug 2022 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiHNO4V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Aug 2022 10:56:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBA175B6
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 07:56:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B25B225FE; Sun, 14 Aug 2022 10:56:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B25B225FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1660488978;
        bh=EKRv2Vt7hnkHgV8MtxOm+AbeEDQhm+txZHOHevHcxoQ=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=WH5rgj2PO2sQTodh5NucA3Bzpqb8h/3WEX72TrbuSzvNdirQxu2IjmMYmYccKOhB6
         liK/ljN0Bdg75UXmeCqjzWG7K2LbMnMogoIqAhs5TLECnCmuzbJtDsbU9pLR3tUX7b
         4u/3y/PSiX/AlR2afFyXWlwnP6+joIeazhoKicrI=
Date:   Sun, 14 Aug 2022 10:56:18 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] DELEG5: Create test file with mode o666
Message-ID: <20220814145618.GA5578@fieldses.org>
References: <166031330113.3080139.1273532571655274363.stgit@morisot.1015granger.net>
 <F2DE58E9-E804-4F5E-9A9D-1EBEEAC9ECE5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DE58E9-E804-4F5E-9A9D-1EBEEAC9ECE5@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, updated the changelog and applied.--b.

On Fri, Aug 12, 2022 at 07:12:42PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 12, 2022, at 10:08 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > 
> > DELEG5   st_delegation.testManyReaddeleg                          : FAILURE
> >           Open which causes recall should return NFS4_OK or
> >           NFS4ERR_DELAY, instead got NFS4ERR_ACCESS
> > ******* CB_Recall (id=14)********
> > **************************************************
> > Command line asked for 1 of 678 tests
> > Of those: 0 Skipped, 1 Failed, 0 Warned, 0 Passed
> > 
> > WARNING: could not clean testdir due to:
> > Making sure b'DELEG5-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY
> > 
> > DELEG5 attempts an OPEN with ACCESS_WRITE to force the recall of
> > a bunch of delegations. The OPEN that requests ACCESS_WRITE fails,
> > however, because the test file was created as 0,0 with mode o644.
> 
> This paragraph could be more clear:
> 
> DELEG5 creates the test file as UID 0 with mode rw-r--r--
> 
> The later OPEN for Write (to trigger delegation recall) is sent as UID 1.
> This OPEN fails because mode rw-r--r-- does not permit UID 1 to open a file
> owned by UID 0 for write.
> 
> 
> > A perhaps more preferable long-term fix would be to follow the
> > advice of the nearby comment and convert DELEG5 to use _get_deleg(),
> > but I'm not expert enough to tackle that yet.
> 
> _get_deleg() creates its test file as UID0 with mode rw-rw-rw-,
> thus side-stepping the subsequent permission conflict. My proposed
> fix simply copies that behavior to DELEG5.
> 
> 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > nfs4.0/servertests/st_delegation.py |    3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
> > index 9c98ec0e0fb3..ba49cf9f09db 100644
> > --- a/nfs4.0/servertests/st_delegation.py
> > +++ b/nfs4.0/servertests/st_delegation.py
> > @@ -244,7 +244,8 @@ def testManyReaddeleg(t, env, funct=_recall, response=NFS4_OK):
> >     c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=0)
> >     cbids = []
> >     fh, stateid = c.create_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,
> > -                                   deny=OPEN4_SHARE_DENY_NONE)
> > +                                   deny=OPEN4_SHARE_DENY_NONE,
> > +                                   attrs={FATTR4_MODE: 0o666})
> >     for i in range(count):
> >         c.init_connection(b'pynfs%i_%s_%i' % (os.getpid(), t.word(), i), cb_ident=0)
> >         fh, stateid = c.open_confirm(t.word(), access=OPEN4_SHARE_ACCESS_READ,
> > 
> > 
> 
> --
> Chuck Lever
> 
> 
