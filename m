Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165C75E5C9
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 02:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGXADi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jul 2023 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXADh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jul 2023 20:03:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223AABD
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jul 2023 17:03:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA904202DC;
        Mon, 24 Jul 2023 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690157005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpKfjKSl5tBYGYbFTH9D8TsruW8hZ+h9uOlwyv+SlFI=;
        b=OeTc83l2pt89CI4bY4ZLb+4Htj75WNkiVjOClOPwcARVbvEa2j+xEID7TFeRDilPk353kD
        br7D7PhM0HqDmZRbSkGhpIoVMeaBQ+EOBxetg0oq4Ls+k6G5EyVPfaAjQkyym2V+7sE2Lp
        Hvb89umn4Iyj6NHegg0ls/oNptlXL/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690157005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpKfjKSl5tBYGYbFTH9D8TsruW8hZ+h9uOlwyv+SlFI=;
        b=FZ9hh5g1kdHPtFUzQ0pOshqIXv1qO8cjMtdOjboDb0k4t1G9cg9roqK+Ys01VOa17E51ip
        BAmbmlm6xISOagBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D34413476;
        Mon, 24 Jul 2023 00:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g3ZFMMu/vWT5LgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jul 2023 00:03:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
In-reply-to: <3A9F5306-EAEE-427C-80D2-E0CD81212238@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>,
 <168966228866.11075.18415964365983945832.stgit@noble.brown>,
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>,
 <168972938409.11078.8409356274248659649@noble.neil.brown.name>,
 <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>,
 <168980881867.11078.6059884952065090216@noble.neil.brown.name>,
 <E93923C4-080B-4B43-9A3B-28A233BF5DFC@oracle.com>,
 <3A9F5306-EAEE-427C-80D2-E0CD81212238@oracle.com>
Date:   Mon, 24 Jul 2023 10:03:18 +1000
Message-id: <169015699813.11078.13302996883028676357@noble.neil.brown.name>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_MED,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Jul 2023, Chuck Lever III wrote:
>=20
> > On Jul 19, 2023, at 7:44 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
> >=20
> >=20
> >=20
> >> On Jul 19, 2023, at 7:20 PM, NeilBrown <neilb@suse.de> wrote:
> >>=20
> >> On Wed, 19 Jul 2023, Chuck Lever III wrote:
> >>>=20
> >>>> On Jul 18, 2023, at 9:16 PM, NeilBrown <neilb@suse.de> wrote:
> >>>>=20
> >>>> On Tue, 18 Jul 2023, Chuck Lever wrote:
> >>>>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> >>>>>> No callers of svc_pool_wake_idle_thread() care which thread was woke=
n -
> >>>>>> except one that wants to trace the wakeup.  For now we drop that
> >>>>>> tracepoint.
> >>>>>=20
> >>>>> That's an important tracepoint, IMO.
> >>>>>=20
> >>>>> It might be better to have svc_pool_wake_idle_thread() return void
> >>>>> right from it's introduction, and move the tracepoint into that
> >>>>> function. I can do that and respin if you agree.
> >>>>=20
> >>>> Mostly I agree.
> >>>>=20
> >>>> It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
> >>>> as there would be no code that can see both the trigger xprt, and the
> >>>> woken rqst.
> >>>>=20
> >>>> I also wonder if having the trace point when the wake-up is requested
> >>>> makes any sense, as there is no guarantee that thread with handle that
> >>>> xprt.
> >>>>=20
> >>>> Maybe the trace point should report when the xprt is dequeued.  i.e.
> >>>> maybe trace_svc_pool_awoken() should report the pid, and we could have
> >>>> trace_svc_xprt_enqueue() only report the xprt, not the rqst.
> >>>=20
> >>> I'll come up with something that rearranges the tracepoints so that
> >>> svc_pool_wake_idle_thread() can return void.
> >>=20
> >> My current draft code has svc_pool_wake_idle_thread() returning bool -
> >> if it found something to wake up - purely for logging.
> >=20
> > This is also where I have ended up. I'll post an update probably tomorrow
> > my time. Too much other stuff going on to finish it today.
>=20
> Pushed to https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> in branch topic-sunrpc-thread-scheduling
>=20

Thanks.
One little thing to fix.
In
    SUNRPC: Report when no service thread is available.
you now have

-	return false;
+
+	trace_svc_pool_starved(serv, pool);
+	percpu_counter_inc(&pool->sp_threads_starved);
+	return NULL;

That should still be "return false" at the end;

NeilBrown
