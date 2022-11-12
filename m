Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263ED62695D
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Nov 2022 13:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKLMdL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Nov 2022 07:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiKLMdK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Nov 2022 07:33:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76476140A3;
        Sat, 12 Nov 2022 04:33:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0657F60BC5;
        Sat, 12 Nov 2022 12:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7211C433C1;
        Sat, 12 Nov 2022 12:33:07 +0000 (UTC)
Date:   Sat, 12 Nov 2022 07:33:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Files in include/trace/events
Message-ID: <20221112073305.0346b827@rorschach.local.home>
In-Reply-To: <20221112072742.065df70a@rorschach.local.home>
References: <20221112072742.065df70a@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 12 Nov 2022 07:27:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Chuck,
> 
> I was just looking over some files in include/trace/events/ and noticed
> that there's sunrpc_base.h, fs.h and nfs.h that are not event files.
> 
> The include/trace/events/ directory should only hold files that are to
> create events, not headers that hold helper functions.
> 
> Can you please move them out of include/trace/events/ as that directory
> is "special" in the creation of events.
> 
> Perhaps we could create a new directory include/linux/trace/ or
> include/trace/linux/ specific for these types of files?
> 

Hi Vlastimil,

I also noticed that mmflags.h is in that directory too.

I'd like to keep only headers defining TRACE_EVENT() in that directory,
as files there have special meaning.

Thanks,

-- Steve
