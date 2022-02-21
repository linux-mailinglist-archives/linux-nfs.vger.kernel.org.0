Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255D64BDEDE
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352437AbiBUKIV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 05:08:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353878AbiBUKHD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 05:07:03 -0500
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [89.1.8.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6154193
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 01:31:50 -0800 (PST)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id F24D812895;
        Mon, 21 Feb 2022 10:31:48 +0100 (CET)
Received: from nas2.garloff.de (xdsl-213-168-119-130.nc.de [213.168.119.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA id 8698711F14;
        Mon, 21 Feb 2022 10:31:45 +0100 (CET)
Received: from [192.168.155.203] (unknown [192.168.155.10])
        by nas2.garloff.de (Postfix) with ESMTPSA id 5AB44B3B0027;
        Mon, 21 Feb 2022 10:31:36 +0100 (CET)
Message-ID: <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de>
Date:   Mon, 21 Feb 2022 10:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de>
 <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
In-Reply-To: <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 8698711F14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

On 21.02.22 02:19, Kornievskaia, Olga wrote:
> ﻿On 2/20/22, 6:17 PM, "Kurt Garloff" <kurt@garloff.de> wrote:
>
>      Hi Olga,
>
>      two updates:
>
>      On 20.02.22 23:26, Kurt Garloff wrote:
>      > Hi Olga,
>      >
>      > your upstream commit 1976b2b3, applied to 5.15.24 as 6f283634 breaks NFS
>      > for me.
>      >
>      > This is while mounting many NFS filesystems from two NFS servers, one
>      > Qnap (nfs v4.1) and one linux 5.15.16 knfsd (nfs v4.2).
>      I have to correct myself. All volumes broken by 5.15.24 come from Qnap.
>      > The NFS mounts just would not succeed. This appears to happen to all
>      > Qnap mounts and one of the mounts from the linux knfsd.
>      This mount also cam from Qnap -- in my mind I had migrated it already,
>      but not in reality :-O
>      > I did some bisecting in 5.15.24 ... reverting 6f283634 and subsequent
>      > NFS/sunRPC patches from you and Xiyu, Anna did the trick to recover from
>      > this failure.
>      > To be precise: I reverted 4403233b 4b22aa42 5ca123c9 c5ae18fa be67be6a
>      > 6f283634 2df6a47a 0c5d3bfb 3cb5b317 58967a23 bbf647ec and 38ae9387 in
>      > 5.15.24. I started reenabling and 2df6aa647a is the last patch that
>      > still results a working NFS for me.
>
>      Also, taking plain 5.15.24 and just reverting 6f283634 creates a
>      kernel that works well with Qnap NFS shares.
>
> Is it possible for you to provide a network trace?

Yes.

Is tcpdump what you'd like to see? wireshark's dumpcap?
Any NFS specific tracing tools I should be using?

One trace with a working kernel and one with the broken one?

Best,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

