Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3E2C8735
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 15:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgK3OzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 09:55:16 -0500
Received: from btbn.de ([5.9.118.179]:50434 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgK3OzP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 09:55:15 -0500
Received: from [IPv6:2001:16b8:64b8:ea00:8985:359a:bb0c:c985] (200116b864b8ea008985359abb0cc985.dip.versatel-1u1.de [IPv6:2001:16b8:64b8:ea00:8985:359a:bb0c:c985])
        by btbn.de (Postfix) with ESMTPSA id 4C9A7259621
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 15:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1606748074;
        bh=mIgk2M796MqJmPDC+eqx02rlCyplm7RsCXkEzpI/Tys=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=EfnGzQWfN3SKrKR8Ixbk7MIJOmb/yYmSt+dT6HQ7JELNqRX+rKE0LyUf29vDKzQzo
         g68L+SBcdSdFqbPLVzPL8i+5dWFlhu6SwfLhlcR0dcV7DkI77ocwG4MSFeEFOVXvpg
         uyMv8PthiY689n52koJMfAFDFH+SdlEYFgqu8objATYU0KfREDijvTXOLA6vKdoaFi
         hab2fygLE47oBjfCg0xXM74NeItgLtFm3KRgOqU1Dlx7odm2rE/wZwh43U/pkyzEl1
         BI0B83fy4iGLcNlYUNjaVqmRZfjIh1oIago25RqNGcbwoY0fmHaVPYA0Awrqzl/3RS
         YgB9CrBeHheRQ==
Subject: Re: linux-5.4.80: "refcount_t: underflow; use-after-free" in
 rpc_async_schedule->rpc_free_task->nfs4_put_copy
From:   Timo Rothenpieler <timo@rothenpieler.org>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f310cd4d-c36e-ee14-2296-aa13b12cb438@rothenpieler.org>
 <81fa8f5a-5ebf-07cb-f9a9-8b3da63f330f@rothenpieler.org>
Message-ID: <d078f7e9-9e42-9783-a0c4-7b05a925d375@rothenpieler.org>
Date:   Mon, 30 Nov 2020 15:54:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <81fa8f5a-5ebf-07cb-f9a9-8b3da63f330f@rothenpieler.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30.11.2020 14:12, Timo Rothenpieler wrote:
> Quick update: I applied that commit on top of the 5.4.80 Kernel, and 
> have not been able to reproduce the issue anymore in a quick test.
> Will leave it running like this for a bit and see if it's fixed.
> 
> I don't know if this is in any way correct though.

Partial success, I guess.

The use after free did not occur again, but users still get their 
singularity pulls stuck, waiting on copy_file_range() to return.
Must have just been a coincidence that those two always happened at the 
same time.

It works fine on a fresh mount, until at some random point all attempts 
lead to it getting stuck.
Re-Mounting, rebooting client or rebooting server all seem to resolve it 
temporarily, until it happens again.
