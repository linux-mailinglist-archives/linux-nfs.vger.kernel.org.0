Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3C5965B6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Aug 2022 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiHPW5i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiHPW5h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 18:57:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13036915D8
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 15:57:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B24351F385;
        Tue, 16 Aug 2022 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660690654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAnR6TFpXQjZD3/Ewe1aVwBto0yeIOUEEsxvvOahbN8=;
        b=tgtpNan3eTGZnd4675nfHj6H8lpil04J1y7SSGkXQ0YIuzTMapuAtVW8JdJDywWzIq0dRt
        vINfzG0QOa/WOczMiSc90yrTXWwnnhJIRuLUiCOSHp+QhVShuUicpqMScfvfEksL25nOuU
        XiPQoUAhKB2U1lhZ+2/HJ8PY3Y7LCvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660690654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAnR6TFpXQjZD3/Ewe1aVwBto0yeIOUEEsxvvOahbN8=;
        b=5gO0AGY0Uc3fPkvKvi3If1UBidhCIMlToFIKlfJuS5OmwACZZ+sY3m9tRJtyBydmsAZPrQ
        M6jcmaTauCExTEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5016139B7;
        Tue, 16 Aug 2022 22:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q3B9I90g/GLJNAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Aug 2022 22:57:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Thoughts on mount option to configure client lease renewal time.
In-reply-to: <729DBD49-62EE-4663-AB4C-97BEF756E8A3@oracle.com>
References: <166060650771.5425.13177692519730215643@noble.neil.brown.name>,
 <729DBD49-62EE-4663-AB4C-97BEF756E8A3@oracle.com>
Date:   Wed, 17 Aug 2022 08:57:29 +1000
Message-id: <166069064993.5425.3612142123797853667@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 17 Aug 2022, Chuck Lever III wrote:
> > On Aug 15, 2022, at 7:35 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > Currently the Linux NFS renews leases at 2/3 of the lease time advised
> > by the server.
> > Some server vendors (Not Exactly Targeting Any Particular Party)
> > recommend very short lease times - as short a 5 seconds in fail-over
> > configurations.  This means 1.7 seconds of jitter in any part of the
> > system can result in leases being lost - but it does achieve fast
> > fail-over. 
> > 
> > If we could configure a 5 second lease-renewal on the client, but leave
> > a 60 second lease time on the server, then we could get the best of both
> > worlds.  Failover would happen quickly, but you would need a much longer
> > load spike or network partition to cause the loss of leases.
> 
> If loss of leases is the only concern (ie, there is no file sharing that
> can cause a client to steal another's locks when the other client loses
> contact with the server) then courteous server should handle that. The
> Linux NFS server is now courteous, and several other implementations are
> as well.

"If" being the key word.  Courteous servers is great and will certainly
help, but doesn't provide the same guarantee as actually getting a
renew in before the lease expires.

> 
> 
> > As v4.1 can end the grace period early once everyone checks in, a large
> > grace period (which is needed for a large lease time) would rarely be a
> > problem.
> 
> IMO the above paragraph is the most salient: if failover time is being
> impacted by state recovery, use NFSv4.1 with implementations that take
> proper advantage of RECLAIM_COMPLETE.
> 
> 
> > So my thought is to add a mount option "lease-renew=5" for v4.1+ mounts.
> > The clients then uses that number providing it is less than 2/3 of the
> > server-declared lease time.
> > 
> > What do people think of this?  Is there a better solution, or a problem
> > with this one?
> 
> RECLAIM_COMPLETE is the preferred solution, if I understand your problem
> statement correctly. Can you describe how it does not meet expectations?
> 

RECLAIM_COMPLETE is an important part of the solution, but not a
complete solution.
If a client is idle (not touching the filesystem for a little while),
then it won't notice the server failover until it sends a renew, which
it might not do for 2/3 the lease time.  e.g. for about 1 minute.
Even if it only takes 1 second to reclaim state and send
RECLAIM_COMPLETE, that is still over 1 minute that the server has to
wait before it can end the grace period.

To reliably reduce the effective grace period, you nee a short renew
time, and the use of RECLAIM_COMPLETE.

> The other side of this coin is that clients can have so much outstanding
> state that they can't recover it all before the grace period expires.
> To compensate, a server can limit the number of delegations it hands out,
> or it can lengthen its lease/grace period.

Maybe an ideal client would estimate the time it would take to recover
all its state, and would ensure the gap between renewal time and lease
time were at least that long.  I don't know that a practical client
would do that though.  Certainly it would make sense for the server to
extend the grace period while a client were actively reclaiming state -
with some limit in case of misbehaving client.

Thanks,
NeilBrown

