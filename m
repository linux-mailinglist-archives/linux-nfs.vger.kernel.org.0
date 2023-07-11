Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770A74EB59
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGKKBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGKKBt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 06:01:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38168A9
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 03:01:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFC24204E9;
        Tue, 11 Jul 2023 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689069706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHLe19ORc2k9oKi4XEu51yYkED1JcEyZpQf1Fkd6EF4=;
        b=SuVCP4gJjey7MXjBL+iZKeSZDfgKVIGyXQ6wzp+P/SEcTSZInAq1OEuDq1umrjUmzYiXSC
        nriQax8Os4/JBEBq1pcGifYgBCEQx9+t0Ln/VTk8xt+0Nx5HCsPTlJAkfJfE8HcrkZz42X
        BnDTujKwDoZYS7WbPFC167kQOfwFL7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689069706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHLe19ORc2k9oKi4XEu51yYkED1JcEyZpQf1Fkd6EF4=;
        b=uMLJEOAa5ZmkKFRTfj5vVg+wb6n6+3egYrm9pwrjexaAf/+t6viAUXaGAXlUC2PkVvhvX3
        mLwt+10c5iEIcOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0D3A1391C;
        Tue, 11 Jul 2023 10:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sUySHIgorWS6awAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 11 Jul 2023 10:01:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "Jeff Layton" <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
In-reply-to: <2211CC3B-806F-461D-A5AA-E95E35E1E408@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>,
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>,
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>,
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>,
 <ZKwYhbo76v8ElI1b@manet.1015granger.net>,
 <168902749573.8939.3668770103738816387@noble.neil.brown.name>,
 <2211CC3B-806F-461D-A5AA-E95E35E1E408@oracle.com>
Date:   Tue, 11 Jul 2023 20:01:41 +1000
Message-id: <168906970156.8939.2877716074642019289@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Chuck Lever III wrote:
> > On Jul 10, 2023, at 6:18 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > What do you think of removing the ability to stop an nfsd thread by
> > sending it a signal.  Note that this doesn't apply to lockd or to nfsv4
> > callback threads.  And nfs-utils never relies on this.
> > I'm keen.  It would make this patch a lot simpler.
> 
> I agree the code base would be cleaner for it.
> 
> But I'm the new kid. I'm not really sure if this is
> part of a kernel - user space API that we mustn't
> alter, or whether it's something that was added but
> never used, or ....
> 
> I can sniff around to get a better understanding.

Once upon a time it was the only way to kill the threads.
There was a syscall which let you start some threads.  You couldn't
change the number of threads, but you could kill them.
And shutdown always kills processes, so letting nfsd threads be killed
meant that would be removed at system shutdown.

When I added the ability to dynamically change the number of threads it
made sense that we could set the number to zero, and then to use that
functionality to shut down the nfs server.  So the /etc/init.d/nfsd
script changed from "killall -9 nfsd" or whatever it was to 
"rpc.nfsd 0".

But it didn't seem sensible to remove the "kill" functionality until
after a transition process, and I never thought the schedule a formal
deprecation.  So it just stayed...

The more I think about it, the more I am in favour of removing it.  I
don't think any other kernel threads can be killed.  nfsd doesn't need
to be special.

Maybe I'll post a patch which just does that.

NeilBrown

