Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F288479B5FA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjIKV7V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbjIKSNj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:13:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98277115;
        Mon, 11 Sep 2023 11:13:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B439AC433C8;
        Mon, 11 Sep 2023 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694456015;
        bh=U66mhFvcY7FXoWeMCGJhYiloQH4p3mMaVs4JuRSv5Bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C6zVXOwhieEhF91NqopvdDJudy1XLMN3/Z4/1ZhuGZKxwYxvAjYc+tuuGfoIyofU1
         o+g4CPaDtsKt+OvlpYoTsugaPvGjltQRA+JUCdyz+WUUL7bJoln4oLrQU/F/EiHxqM
         Ot/JiJBSfDiXmR/s0xaDSFP/3WV2SGRuNX8uOzH8=
Date:   Mon, 11 Sep 2023 11:13:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
Message-Id: <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>
In-Reply-To: <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
        <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 11 Sep 2023 10:39:43 -0400 Chuck Lever <cel@kernel.org> wrote:

> lwq is a FIFO single-linked queue that only requires a spinlock
> for dequeueing, which happens in process context.  Enqueueing is atomic
> with no spinlock and can happen in any context.

What is the advantage of this over using one of the library
facilities which we already have?
