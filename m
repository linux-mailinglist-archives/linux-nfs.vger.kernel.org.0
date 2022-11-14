Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684A628367
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 16:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiKNPCh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 10:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiKNPCg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 10:02:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E31E71A;
        Mon, 14 Nov 2022 07:02:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B75ACCE10E4;
        Mon, 14 Nov 2022 15:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CDDC433D6;
        Mon, 14 Nov 2022 15:02:26 +0000 (UTC)
Date:   Mon, 14 Nov 2022 10:03:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] trace: Relocate event helper files
Message-ID: <20221114100307.6abba30a@gandalf.local.home>
In-Reply-To: <166843574651.160660.16747506894761495587.stgit@klimt.1015granger.net>
References: <166843574651.160660.16747506894761495587.stgit@klimt.1015granger.net>
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

On Mon, 14 Nov 2022 09:36:39 -0500
Chuck Lever <chuck.lever@oracle.com> wrote:

> > Can you please move them out of include/trace/events/ as that
> > directory is "special" in the creation of events.  
> 
> That should be documented somewhere, but I couldn't think of a
> place to write it down.

Probably needs to be updated in the Documentation/trace/events.rst?

-- Steve
