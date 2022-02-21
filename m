Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E74BE2D9
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355569AbiBULOL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 06:14:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355472AbiBULNd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 06:13:33 -0500
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de [89.1.8.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD9286ED
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 02:48:35 -0800 (PST)
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
        by cc-smtpout3.netcologne.de (Postfix) with ESMTP id 9A5171218F;
        Mon, 21 Feb 2022 11:48:33 +0100 (CET)
Received: from nas2.garloff.de (xdsl-213-168-119-130.nc.de [213.168.119.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA id 4D06C11D90;
        Mon, 21 Feb 2022 11:48:29 +0100 (CET)
Received: from [192.168.155.203] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 91003B3B0027;
        Mon, 21 Feb 2022 11:48:21 +0100 (CET)
Message-ID: <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
Date:   Mon, 21 Feb 2022 11:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Kurt Garloff <kurt@garloff.de>
To:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
In-Reply-To: <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 4D06C11D90
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On 21.02.22 10:31, Kurt Garloff wrote:
> Hi Olga,
>
> On 21.02.22 02:19, Kornievskaia, Olga wrote:
>> [...]
>> Is it possible for you to provide a network trace?
>
> Yes.
>
> Is tcpdump what you'd like to see? wireshark's dumpcap?
> Any NFS specific tracing tools I should be using?
>
> One trace with a working kernel and one with the broken one?

Comparing the good and the bad trace ...

mount -t nfs 192.168.155.74:/Public /mnt/Public
against Qnap 4.3.4.xxx NFS v4.1 server.

Both do:

Establish conn
NFS NULL (ack)
NFS EXCHANGE_ID (4.2 -> NFS4ERR_MINOR_VERS_MISMATCH)
Teardown and reestablish
NFS NULL (ack)
NFS EXCAHNGE_ID (4.1 -> ack)
NFS EXCAHNGE_ID (4.1 -> ack)
NFS CREATE_SESSION (ack)
NFS RECLAIM_COMPLETE (CB_NULL, ack)
NFS_SECINFO_NO_NAME (ack)
NFS PUTROOTFH|GETATTR (ack)
NFS GETATTR FH:0x62d40c52 (ack), 8 times
NFS ACCESS FH_ -x62d40c52 (denied md xt dl, alllowed rd lu)
NFS LOOKUP DH:0x62d40c52/Public (ack)
NFS LOOKUP DH:0x62d40c52/Public (ack)
NFS GETATTR FH:0x8ee88cee (ack), 3 times


Now the differences start:

The fixed NFS client repeatedly gets ack back, the broken NFS client gets

NFS GETATTR FH:0x8ee88cee (NFS4ERR_DELAY), repeating forever (exp. backoff)


If someone else wants to look at the pcapng data, let me know.

HTH,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

