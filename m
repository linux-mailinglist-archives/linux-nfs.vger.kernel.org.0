Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958B223BADD
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 15:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHDNI3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 09:08:29 -0400
Received: from btbn.de ([5.9.118.179]:35230 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgHDNI3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Aug 2020 09:08:29 -0400
X-Greylist: delayed 8156 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2020 09:08:28 EDT
Received: from [IPv6:2001:16b8:64d7:4500:fc3b:cfd2:151e:7636] (200116b864d74500fc3bcfd2151e7636.dip.versatel-1u1.de [IPv6:2001:16b8:64d7:4500:fc3b:cfd2:151e:7636])
        by btbn.de (Postfix) with ESMTPSA id 948304D609;
        Tue,  4 Aug 2020 15:08:27 +0200 (CEST)
Subject: Re: NFS over RDMA issues on Linux 5.4
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
Date:   Tue, 4 Aug 2020 15:08:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 04.08.2020 14:49, Chuck Lever wrote:
> Timo, I tend to think this is not a configuration issue.
> Do you know of a known working kernel?
> 

This is a brand new system, it's never been running with any kernel 
older than 5.4, and downgrading it to 4.19 or something else while in 
operation is unfortunately not easily possible. For a client it would 
definitely not be out of the question, but the main nfs server I cannot 
easily downgrade.

Also keep in mind that the dmesg spam happens on both server and client 
simultaneously.

I'll see if I can borrow two of the nodes to turn into a temporary test 
system for this.

The Kernel for this system is self-built and not any distribution 
kernel. This could not be a missing kernel config option or something?
