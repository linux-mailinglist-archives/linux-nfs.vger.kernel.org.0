Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BDC23A928
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCPLM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 11:11:12 -0400
Received: from btbn.de ([5.9.118.179]:53806 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCPLM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Aug 2020 11:11:12 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 11:11:11 EDT
Received: from [IPv6:2001:16b8:6478:5500:44fa:818:1e31:9c59] (200116b86478550044fa08181e319c59.dip.versatel-1u1.de [IPv6:2001:16b8:6478:5500:44fa:818:1e31:9c59])
        by btbn.de (Postfix) with ESMTPSA id 26B97200435
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 17:05:53 +0200 (CEST)
To:     linux-nfs@vger.kernel.org
From:   Timo Rothenpieler <timo@rothenpieler.org>
Subject: NFS over RDMA issues on Linux 5.4
Message-ID: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
Date:   Mon, 3 Aug 2020 17:05:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I have just deployed a new system with Mellanox ConnectX-4 VPI EDR IB 
cards and wanted to setup NFS over RDMA on it.

However, while mounting the FS over RDMA works fine, actually using it 
results in the following messages absolutely hammering dmesg on both 
client and server:

> https://gist.github.com/BtbN/9582e597b6581f552fa15982b0285b80#file-server-log

The spam only stops once I forcibly reboot the client. The filesystem 
gets nowhere during all this. The retrans counter in nfsstat just keeps 
going up, nothing actually gets done.

This is on Linux 5.4.54, using nfs-utils 2.4.3.
The mlx5 driver had enhanced-mode disabled in order to enable IPoIB 
connected mode with an MTU of 65520.

Normal NFS 4.2 over tcp works perfectly fine on this setup, it's only 
when I mount via rdma that things go wrong.

Is this an issue on my end, or did I run into a bug somewhere here?
Any pointers, patches and solutions to test are welcome.


Thanks,
Timo Rothenpieler
