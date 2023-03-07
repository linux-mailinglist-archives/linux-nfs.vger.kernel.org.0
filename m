Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A76AFA2B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 00:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCGXU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 18:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCGXUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 18:20:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E09E318;
        Tue,  7 Mar 2023 15:20:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 119491FE26;
        Tue,  7 Mar 2023 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678231251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMrWr+VoLJb8eV9cWCPJgwNzeJNpYJum7vLTBxBsNyk=;
        b=Qg2kW99mPIQpQEPmoLij9WuZWAGey9AXl/BYkX9Fl3ptIVz//ZTXSLdbN7GTf6AqKQ/DJ7
        QMgtkgE8AUBtGuWJr4mFSMP0xVxC3xCTpdciFzcycLgrlqF1O/AzHEtZ5CdPNJtysYthP2
        f6vBCHMJfMfScfnUds8v3EyxxictXww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678231251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMrWr+VoLJb8eV9cWCPJgwNzeJNpYJum7vLTBxBsNyk=;
        b=QB6kSoRGVEgFn/VmLXPwOkHCMNGiCiByihGeyFmcjTb5yOxkE4qo1xX8v8mMsPqzArbxcS
        k33IhxX6GscHt2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3102313440;
        Tue,  7 Mar 2023 23:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1xN8Ns/GB2TYGQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Mar 2023 23:20:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jerry Zhang" <jerry@skydio.com>
Cc:     embedded@skydio.com, "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: Fix incorrect parsing of expiry time
In-reply-to: <CAMKO5Cv1Uh1rSFQ0cR1kfA88iXXHP5RMO-euU15Xrn2i93J5rg@mail.gmail.com>
References: <20230307220525.54895-1-Jerry@skydio.com>,
 <167822825917.8008.11050193827453206272@noble.neil.brown.name>,
 <CAMKO5Cv1Uh1rSFQ0cR1kfA88iXXHP5RMO-euU15Xrn2i93J5rg@mail.gmail.com>
Date:   Wed, 08 Mar 2023 10:20:42 +1100
Message-id: <167823124256.8008.4738010782615192469@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 08 Mar 2023, Jerry Zhang wrote:
> On Tue, Mar 7, 2023 at 2:31 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 08 Mar 2023, Jerry Zhang wrote:
> > > The expiry time field is mean to be expressed in seconds since boot.
> >
> > Correct.
> >
> > > The get_expiry() function parses a relative time value in seconds.
> >
> > Incorrect.  It parses and absoulte wall-clock time.
> I'm not familiar with the source of truth for this info. Is there a
> specification of some sort?
> 
> For reference, we were seeing writes to
> /proc/net/rpc/nfsd.export/channel randomly fail with EINVAL despite
> usually succeeding with the same invocation. Upon investigation this
> was the string that exportfs was writing "-test-client- /path/to/mount
>  3 0 65534 65534 0". "3" was the value for expiry in this message,
> which led me to conclude that this is a relative field. If it isn't,
> perhaps this is a bug in userspace nfs tools?

The above information is very useful.  This sort of detail should always
be included with a bug report, or a patch proposing to fix a bug.

The intent of that "3" is to be a time in the past.  We don't want the
-test-client- entry to be added to the cache, but we want a failure
message if the path cannot be exported.  So we set a time in the past as
the expiry time.
Using 0 is awkward as it often has special meaning, so I chose '3'. 

> 
> The failure in this was if nfs-server starts exactly 3s after bootup,
> boot.tv_sec would be 3 and thus get_expiry() returns 0, causing a
> failure to be returned.

I don't understand this. getboottime64() doesn't report time since boot.
It reports the time when the system booted.  It only changes when the
system time is deliberately changed.
At boot, it presumably reports 0.  As soon as some tool (e.g. systemd or
ntpdate) determines what the current time it and calls settimeofday() or
a similar function, the system time is changed, and the boot-time is
changed by the same amount.  Typically this will make it well over 1
billion (for anything booted this century).
So for the boot time to report as '3', something would need to set the
current time to a moment early in January 1970.  I'd be surprised if
anything is doing that.

How much tracing have you done?  Have you printed out the value of
boot.tv_sec and confirmed that it is '3' or have you only deduced it
from other evidence.
Exactly what firm evidence do you have?

Thanks,
NeilBrown

