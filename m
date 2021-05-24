Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809AB38E8F6
	for <lists+linux-nfs@lfdr.de>; Mon, 24 May 2021 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhEXOpj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 May 2021 10:45:39 -0400
Received: from bronze1.eecs.yorku.ca ([130.63.94.75]:51284 "EHLO
        bronze1.eecs.yorku.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhEXOph (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 May 2021 10:45:37 -0400
Received: from [170.133.224.154] (helo=[192.168.1.136])
        by bronze1.eecs.yorku.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2-31-503e55a2c)
        (envelope-from <jas@eecs.yorku.ca>)
        id 1llBoO-0012Sp-BD; Mon, 24 May 2021 10:44:08 -0400
Subject: Re: ksu problem with sec=krb5 and nfs
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <abbd93ac-4a68-a471-fbb4-a9baf05b89c9@eecs.yorku.ca>
 <7714ABF4-E9CD-424B-BF7F-6F1B91F58C2B@redhat.com>
From:   Jason Keltz <jas@eecs.yorku.ca>
Message-ID: <dd51738b-b2c2-2dcf-68b1-e78c66d08b28@eecs.yorku.ca>
Date:   Mon, 24 May 2021 10:44:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7714ABF4-E9CD-424B-BF7F-6F1B91F58C2B@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Score: -101.0
X-Spam-Level: ---------------------------------------------------
X-Spam-Report: Content analysis details:   (-101.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -100 SHORTCIRCUIT           Not all rules were run, due to a shortcircuited
                             rule
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

That's exactly it - I definately want ksu to be writing that exact 
file.  Any idea why it isn't, and why it matters if the home directory 
is using sec=krb5 or not?

Jason.

On 5/24/2021 7:30 AM, Benjamin Coddington wrote:
> On 22 May 2021, at 10:47, Jason Keltz wrote:
>
>> Can someone help me understand the issue, and whether there is a solution?
> Don't you want ksu to write its target cache to /tmp/krb5cc_1011 so rpc.gssd
> can find it?  Why isn't that happening?
>
> Ben
>
>
