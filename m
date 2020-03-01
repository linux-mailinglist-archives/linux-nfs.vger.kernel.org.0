Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8D174EC5
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2020 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCARtE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 12:49:04 -0500
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net ([68.178.252.235]:60357
        "EHLO p3plsmtpa12-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgCARtE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 12:49:04 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 12:49:04 EST
Received: from [172.20.1.219] ([50.235.29.75])
        by :SMTPAUTH: with ESMTPSA
        id 8Sb3j13lvkAzH8Sb3jrVWO; Sun, 01 Mar 2020 10:41:45 -0700
X-CMAE-Analysis: v=2.3 cv=avfM9hRV c=1 sm=1 tr=0
 a=VA9wWQeJdn4CMHigaZiKkA==:117 a=VA9wWQeJdn4CMHigaZiKkA==:17
 a=IkcTkHD0fZMA:10 a=48vgC7mUAAAA:8 a=dl1bIT7xQbrqBEUhPN8A:9 a=QEXdDO2ut3YA:10
 a=w1C3t2QeGrPiZgrLijVG:22
X-SECURESERVER-ACCT: tom@talpey.com
To:     nfsv4-chairs <nfsv4-chairs@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Tom Talpey <tom@talpey.com>
Subject: FYI on an update to "RDMA Flush" I-D and IETF107
Message-ID: <03bf747f-b255-677d-1e6c-900accac463c@talpey.com>
Date:   Sun, 1 Mar 2020 09:41:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFNMjTJqj1BhC44LWvvj+TBFrQwl198ze/EftJBeC4SrZZtCa0Wy3vBbuxIN+0AlkI/RgsD+5fzFhHr1QBFsj+1fNlK8u8WvKeP2QhnBKmLjO4fBznfV
 lBSxRDQ4zW2KSOxOFNf/Sw1ELTEZPIdSzt3c/qhha+EGcA70HKYlDS5ehmWab+KrZyh7aHB0CeMWgTTgSLVLAKc3pZeMqa+j3Is=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A couple of things FYI.

- I am updating the draft-talpey-rdma-commit document* in
advance of IETF107. This is an iWARP extension in support of
RDMA access to persistent memory, although it is somewhat more
general than simply pmem. There is a parallel effort in IBTA.

- Because there is no longer an RDDP working group, one option
discussed in the past with several WG chairs and Transport ADs was
to move this forward in the NFSv4 WG. With the new chair situation,
and the document republication, it may be worthwhile to discuss
this again. I believe there is good merit to the idea.

- I plan to attend IETF107 NFSv4 WG meeting, but can only be
there one day. I hope to discuss this further there. If you
would like me to say something as part of the agenda, I am
happy to do so.

Tom.


* https://datatracker.ietf.org/doc/draft-talpey-rdma-commit/
