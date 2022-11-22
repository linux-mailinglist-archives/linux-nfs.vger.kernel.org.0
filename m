Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE2633A06
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Nov 2022 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiKVK0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Nov 2022 05:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiKVKZ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Nov 2022 05:25:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D24FFBC;
        Tue, 22 Nov 2022 02:23:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 651791F86C;
        Tue, 22 Nov 2022 10:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669112584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHzV88qQP/OD/4XbS3raKu1Jt+MEZU4CjnRrN3yPtEs=;
        b=rCWypofxzC08J+ttVcdlgI0xmmleLlC5tk5vsGUjlSzNtLCT3Tn1ZXS/z4gf072vC1S39z
        cpVJbaKyhFt4+E3CroMOv7ngC1yv6SCMzDXS5wfpVYO2pbX+g2gNKf8ykb+auNPgIgaV8u
        usjIaYu35u0u5NDScJpxJPlsPqypCiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669112584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHzV88qQP/OD/4XbS3raKu1Jt+MEZU4CjnRrN3yPtEs=;
        b=iZG6CcHouX7eeWgV41zznvLEzxgQhTvTAlPI1cUe5asgc+I0ltSPl8mWiYw5brHZYL7Hsv
        Qc2Fq/UE9FMVvVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B6CE13B01;
        Tue, 22 Nov 2022 10:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3xV9CQijfGOdWgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 10:23:04 +0000
Message-ID: <0f8da54c-b442-e4ae-770c-4e9919bb7bfa@suse.cz>
Date:   Tue, 22 Nov 2022 11:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Files in include/trace/events
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20221112072742.065df70a@rorschach.local.home>
 <20221112073305.0346b827@rorschach.local.home>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221112073305.0346b827@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/12/22 13:33, Steven Rostedt wrote:
> On Sat, 12 Nov 2022 07:27:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Hi Chuck,
>> 
>> I was just looking over some files in include/trace/events/ and noticed
>> that there's sunrpc_base.h, fs.h and nfs.h that are not event files.
>> 
>> The include/trace/events/ directory should only hold files that are to
>> create events, not headers that hold helper functions.
>> 
>> Can you please move them out of include/trace/events/ as that directory
>> is "special" in the creation of events.
>> 
>> Perhaps we could create a new directory include/linux/trace/ or
>> include/trace/linux/ specific for these types of files?
>> 
> 
> Hi Vlastimil,
> 
> I also noticed that mmflags.h is in that directory too.
> 
> I'd like to keep only headers defining TRACE_EVENT() in that directory,
> as files there have special meaning.

I guess we could move that one to e.g. mm/mmflags.h as it's used also
outside of trace events anyway (mm/debug.c), but it's not something to
expose to general use in include/ But most includes are from proper
include/trace/events/*.h headers so dunno, maybe
include/trace/<something>/mmflags.h would be more appropriate.

> Thanks,
> 
> -- Steve

