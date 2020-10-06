Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A5285087
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJFROa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 13:14:30 -0400
Received: from p3plsmtpa09-06.prod.phx3.secureserver.net ([173.201.193.235]:53816
        "EHLO p3plsmtpa09-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgJFRO3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 13:14:29 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 13:14:29 EDT
Received: from [192.168.0.117] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id PqQgkZI9Iz5JkPqQgkhcef; Tue, 06 Oct 2020 10:07:11 -0700
X-CMAE-Analysis: v=2.3 cv=aPSOVo1m c=1 sm=1 tr=0
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=mJjC6ScEAAAA:8 a=mRtmDtF74R81MPjdODkA:9 a=QEXdDO2ut3YA:10
 a=ijnPKfduoCotzip5AuI1:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: unsharing tcp connections from different NFS mounts
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20201006151335.GB28306@fieldses.org>
 <43CA4047-F058-4339-AD64-29453AE215D6@oracle.com>
 <20201006152223.GD28306@fieldses.org>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <bb58e43a-f23d-d5f5-ac53-9230267f7faa@talpey.com>
Date:   Tue, 6 Oct 2020 13:07:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006152223.GD28306@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPCEQ6bn2vaz27JHv+0OlRx36SR0tGTMknVNIpuVIOZB41UhOMYNFFjkcDl8QVoBWOQtOnoEtxVIIrStlEqX+INRbCV+eKRGKPWMw8FCCeIOMpXMiazE
 IxvNQkNUOseCw3RUlXSOuoGOhluDFDP9Sbx125zbxpCTthurZBISd54Td6SBIHoDq+xy9+BHEHKLo92tzVgWP4FKtd7zDqUOpD4mbCsalY7XFYNUzixZrUF4
 BziFC47QoSYIBSO0l0Z0xQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/6/2020 11:22 AM, Bruce Fields wrote:
> On Tue, Oct 06, 2020 at 11:20:41AM -0400, Chuck Lever wrote:
>>
>>
>>> On Oct 6, 2020, at 11:13 AM, bfields@fieldses.org wrote:
>>>
>>> NFSv4.1+ differs from earlier versions in that it always performs
>>> trunking discovery that results in mounts to the same server sharing a
>>> TCP connection.
>>>
>>> It turns out this results in performance regressions for some users;
>>> apparently the workload on one mount interferes with performance of
>>> another mount, and they were previously able to work around the problem
>>> by using different server IP addresses for the different mounts.
>>>
>>> Am I overlooking some hack that would reenable the previous behavior?
>>> Or would people be averse to an "-o noshareconn" option?
>>
>> I thought this was what the nconnect mount option was for.
> 
> I've suggested that.  It doesn't isolate the two mounts from each other
> in the same way, but I can imagine it might make it less likely that a
> user on one mount will block a user on another?  I don't know, it might
> depend on the details of their workload and a certain amount of luck.

Wouldn't it be better to fully understand the reason for the
performance difference, before changing the mount API? If it's
a guess, it'll come back to haunt the code for years.

For example, maybe it's lock contention in the xprt transport code,
or in the socket stack.

Just askin'.

Tom.
