Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862079C3A7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 05:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbjILDEr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 23:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbjILDEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 23:04:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971E3527B;
        Mon, 11 Sep 2023 19:37:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5425C433C7;
        Tue, 12 Sep 2023 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694486230;
        bh=1GN4HF80LygC69tBuSRIzYli/IaF2whxkFX0gy1DmLE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=RmbJOBwm1kIk3ieTuV0lxF2KeEE63geMepLt6Sy692HrkwaSWYzVjE4P/MDdhn8tA
         59QeXZcwfqqXddqRE2SFEqXPRI38hOX5d3nIJneOEoEQ1Xqr1Gh/vi3tkdOI8GbH1W
         xpc5y95hU6P5udEZzfiC3Rvko0Lgy4g8C/KElx6TqvOJd0ojGctOdVQgaJk/HZbjlK
         WKMC03jANSM/26Rd1GqzEqFVUBy1YqTJGEBAq+SHKtUtZSPPcpzI0Mcc3HUh1q5DOb
         h9P78efk1FKjGcoHsJuslfnrurzGd0e6V+AgMhhQW+jqDd2akryqS84g1pGq8tWIB6
         J5xD7ePOC4cvg==
Date:   Mon, 11 Sep 2023 19:37:08 -0700
From:   Kees Cook <kees@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
CC:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
User-Agent: K-9 Mail for Android
In-Reply-To: <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net> <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
Message-ID: <0D0F3EEB-B837-4C65-95BF-99ACF3169206@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On September 11, 2023 7:39:43 AM PDT, Chuck Lever <cel@kernel=2Eorg> wrote:
>From: NeilBrown <neilb@suse=2Ede>
> [=2E=2E=2E]
> Does not use kunit framework=2E

Any reason why not? It seems like it'd be well suited to it=2E=2E=2E


--=20
Kees Cook
