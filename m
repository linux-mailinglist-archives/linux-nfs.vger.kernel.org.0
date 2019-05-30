Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181B130097
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfE3RMY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 13:12:24 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:44132
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbfE3RMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 13:12:24 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 13:12:24 EDT
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id WOUDh6DqsqJz9WOUDh6HVD; Thu, 30 May 2019 10:05:06 -0700
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     NeilBrown <neilb@suse.com>, Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
Date:   Thu, 30 May 2019 13:05:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHotrCDW8LfWFHbzjXUttE/chEOfBdF179JzpT5kNoL5haycCKZLwA7PwMgE2ujtqgW/OFklXAWa/QbL8y5XogtX9afl8HevkPaPVbyuwVKhCNb3JjZ+
 ngwFuCM5EMCI6HHwDV87k8UxibJR24bb48hn4bMw+8vc3wTcCrQ59np6McMMja8Cw4UmZ+oqMtpWoMFSq4ezVaQasi2i3uBCnlCPULLc9RLQJHqevgt0d7WD
 S2f9sLRDOUG/vR409Mj+kpp/lCdjAEgk5dCre6bER0UELs/K+K+v+I8qjwrV/kreDB+Lvln8a1MSbArF5WVpgt/+eTX2CfFGr4EGHc2siGw=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/29/2019 8:41 PM, NeilBrown wrote:
> I've also re-arrange the patches a bit, merged two, and remove the
> restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
> these restrictions were not needed, I can see no need.

I believe the need is for the correctness of retries. Because NFSv2,
NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
duplicate request caches are important (although often imperfect).
These caches use client XID's, source ports and addresses, sometimes
in addition to other methods, to detect retry. Existing clients are
careful to reconnect with the same source port, to ensure this. And
existing servers won't change.

Multiple connections will result in multiple source ports, and possibly
multiple source addresses, meaning retried client requests may be
accepted as new, rather than having any chance of being recognized as
retries.

NFSv4.1+ don't have this issue, but removing the restrictions would
seem to break the downlevel mounts.

Tom.

