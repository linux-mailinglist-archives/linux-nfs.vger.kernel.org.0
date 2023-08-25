Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1151788D0A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbjHYQNn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbjHYQN1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 12:13:27 -0400
Received: from mail.digitalelves.com (mail.digitalelves.com [198.211.96.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D053270E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thebarn.com;
        s=default; t=1692979960;
        bh=CFTPtaBuPXYMwSXQVoVdKtZ9bQSC97GxqZ09sZHMaB8=;
        h=Date:From:Subject:Reply-To:To:References:In-Reply-To:From;
        b=odsMIX5xUg+qUwO3lFAJ3U551ucaMiW6FoIKdU7MGuGuYvCmp0rzmCGFwn2KuRQKF
         557xENcq2bIPPES6nO9F2S3C88TcIqu/U0w4iPmx+3VE8vt9ZcJysb+C8+ABH4Wszf
         PdubuePLpYH7v/tYmWbi9vFCZv1DBmnOwT8OQsJg=
Received: from [192.168.1.162] (c-73-94-102-169.hsd1.mn.comcast.net [73.94.102.169])
        by mail.digitalelves.com (Postfix) with ESMTPSA id 93ED213B6F6
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 16:12:39 +0000 (UTC)
Message-ID: <11a5110b-0769-de07-10a4-d266dbb8c5c0@thebarn.com>
Date:   Fri, 25 Aug 2023 11:12:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Russell Cattelan <cattelan@thebarn.com>
Subject: Re: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Reply-To: Russell Cattelan <cattelan@thebarn.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <09b207aa-3670-90e8-9a04-1c35c1397a0c@thebarn.com>
Content-Language: en-US
In-Reply-To: <09b207aa-3670-90e8-9a04-1c35c1397a0c@thebarn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > Hi, there!
> > 
> > We have some shares that use NFSv3 with TCP and Kerberos and have
> > been
> > hitting an intriguing issue with those. We have noticed that network
> > instabilities have been causing some 'Permission denied' errors on
> > files.
> > 
> > The current scenario we have is based on NFSv3 over TCP clients,
> > configured with Kerberos (krb5p) authentication against a NetApp NFS
> > Server (ONTAP).  This is happening regardless of the Kernel we use
> > (our main tests bear 4.15 and 5.15 generic Ubuntu Kernels - from
> > Bionic and Jammy), and we have not found any interesting commits in
> > either components upstream that would change the behaviour in hand.
> > 
> > We tracked those issues down and found out that the 'Permission
> > denied' happens because our packets are failing the GSS checksum.
> > We kept investigating and discovered, after some tcpdump, that this
> > happens because the client retransmits RPC packets, which increases
> > the GSS sequence number. Meanwhile, the response to the original
> > packet gets received, but the checksum fails because the client is
> > expecting a different GSS sequence number.
> > 
> > This can be avoided with NFSv4 because the RPC client is created with
> > a "no retrans timeout" flag. Such a flag is not set and is
> > impossible to set on NFSv3. We did some investigation and thought
> > that
> > setting this flag would fix our problems without the need to move to
> > NFSv4.
> > 
> > Our question is: is there a reason this flag is not being set nor is
> > it possible to set it for NFSv3? Is there something on NFSv3 that
> > demands RPC retransmissions even with TCP?  One "hint" we have come
> > across is that it is *explicitly mentioned* in NFSv4's RFC, and
> > there is nothing in NFSv3 at all - most likely due to the fact we're
> > dealing with a stateless protocol.
> > 
> > Any comments would be greatly appreciated here!
> > 
> > Thank you,
> > 
> > [1]
> > https://github.com/torvalds/linux/blob/v5.15/net/sunrpc/auth_gss/gss_krb5_unseal.c#L194
> > [2] https://github.com/torvalds/linux/blob/v5.15/fs/nfs/client.c#L521
> > [3] https://datatracker.ietf.org/doc/html/rfc7530#section-3.1.1
>
> NFSv3 servers are allowed to drop requests, and NFSv3 clients are
> expected to retransmit them when this happens. NFSv4 servers may not
> drop requests, and NFSv4 clients are expected never to retransmit
> (unless the connection breaks). For that reason we do set
> RPC_TASK_NO_RETRANS_TIMEOUT on NFSv4 and do not on NFSv3.
>
We have been doing a bunch of debugging on this issue and the key point / problem we are
running into is that because this is a kerberos enabled mount when the client does a
re-transmit it ends up generating a new MIC header / checksum since the krb5 context
sequence number has moved on.

If that retrans happens before the original response is received then the mic verification
fails since the client is now expecting a response to the second packet and not the first.
mic header verification fails which then results in an EACCES error which ends up as an IO
error at the application.

What we have found that is it easy to repro in our environment adding an iptables
rule to drop responses from the nfs server for 55-63 seconds.
Less than 55 sec and the retrans does not happen things recover
More than 63 sec and the rpc code goes down the reconnect path before doing the retrans and
things recover.

It seems like kerberos enabled mounts should be using RPC_TASK_NO_RETRANS_TIMEOUT since doing
a retrans changes the GSS checksum from the original checksum.


--Russell Cattelan


