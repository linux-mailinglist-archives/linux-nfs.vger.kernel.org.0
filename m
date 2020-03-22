Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC88718E745
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2020 08:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCVHDO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Mar 2020 03:03:14 -0400
Received: from gandalf.kite.hu ([212.92.8.81]:42104 "EHLO gandalf.kite.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVHDO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Mar 2020 03:03:14 -0400
Received: (qmail 22759 invoked from network); 22 Mar 2020 07:03:11 -0000
Received: from fibhost-66-103-77.fibernet.hu (HELO ?192.168.0.3?) (muszi@85.66.103.77)
  by gandalf.kite.hu with ESMTPA; 22 Mar 2020 07:03:11 -0000
Subject: Re: NFSv3 directory traversal causes lockup in 4.9.214
From:   Bartos-Elekes Zsolt <muszi@kite.hu>
To:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9b126ee3-a51c-76f8-aa97-312f3e76f866@kite.hu>
Message-ID: <f9afd297-24d7-0343-6bdf-b2ead1cedc0f@kite.hu>
Date:   Sun, 22 Mar 2020 08:03:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <9b126ee3-a51c-76f8-aa97-312f3e76f866@kite.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

> I think I found a bug in 4.9.214: a simple directory traversal of a NFSv3-mounted filesystem causes system lockup after 
> a few seconds - everything attempting NFS and local disk access is blocked. The machine is still alive (responding to 
> pings and on the console), but I can't start any new programs.
> 
> 
> 4.9.213 is OK, 4.9.214 is not.
> 
> If we revert commit 67a56e9743171bdacddbdc05a58735aa024bb474 (commit 4b310319c6a8ce708f1033d57145e2aa027a883c upstream), 
> the problem goes away.
> 
> 
> How to trigger the problem:
> 
> mount nfs-server.example.com:/ /mnt/net -o vers=3,ro
> find /mnt/net
> 
> 
> I have observed this only on two older machines running in i386 mode (my home server, an Intel D2500HN, and a test 
> machine, a Lenovo ThinkCentre A57 (Product ID: 9851-7AG)), but could not trigger the bug on a Pentium III machine (all 
> three running the very same kernel).

I reply to myself: commit dbfc9e9878561da92cdcda41f321137c16966587 ("NFS: Remove superfluous kmap in 
nfs_readdir_xdr_to_array") in 4.9.217 fixes it.

-- 
Best regards,
Zsolt
