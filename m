Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18751B7AAC
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbfISNkI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 09:40:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389222AbfISNkH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 09:40:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA5D67BDA2;
        Thu, 19 Sep 2019 13:40:07 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-74.phx2.redhat.com [10.3.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7775D6B0;
        Thu, 19 Sep 2019 13:40:07 +0000 (UTC)
Subject: Re: support for UDP
To:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <CAN-5tyG97C6GTXOz5G6z8SL+jNKYa0siWnSfjijRNVucFs3KwA@mail.gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <05e6e3ea-35c6-e4e0-3ba6-6a9ee0b86592@RedHat.com>
Date:   Thu, 19 Sep 2019 09:40:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAN-5tyG97C6GTXOz5G6z8SL+jNKYa0siWnSfjijRNVucFs3KwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 13:40:07 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/13/19 11:14 AM, Olga Kornievskaia wrote:
> Hi folks,
> 
> I'd like to gauge what people think. Do you think we'd ever do a bold
> thing like drop the UDP support in the upstream kernel (obviously with
> a plan to fade it out with a config option that we did with the des
> support)...
> 
Starting with Fedora 29 and RHEL7 UDP mounts are no longer negotiated.
The command line argument is need to do a UDP mount.

Again starting with Fedora 29 and now RHEL8 UDP is off by default
on the NFS servers. A configuration change is needed for UDP mounts.

We did this to cut the testing matrix in half... 

We've not had any push back on the lack of UDP support. 

Personally I think it is long overdue... 

My two cents,

steved.
