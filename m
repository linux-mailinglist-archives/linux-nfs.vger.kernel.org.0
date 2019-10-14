Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A05D694A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2019 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfJNSQR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Oct 2019 14:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbfJNSQR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Oct 2019 14:16:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F54018C8921;
        Mon, 14 Oct 2019 18:16:17 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-253.phx2.redhat.com [10.3.116.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E801560C18;
        Mon, 14 Oct 2019 18:16:16 +0000 (UTC)
Subject: Re: [PATCH 0/3] some nfs-utils patches.
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
References: <156921267783.27519.2402857390317412450.stgit@noble.brown>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <0763ec95-15ff-b31a-8743-eaf5286ee0f1@RedHat.com>
Date:   Mon, 14 Oct 2019 14:16:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <156921267783.27519.2402857390317412450.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 14 Oct 2019 18:16:17 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/23/19 12:26 AM, NeilBrown wrote:
> These free are largely unrelated.
> The only connection is that without the second, I get
> warnings because my /etc/nfs.conf includes /etc/nfs.conf.local - just
> in case.
> Then, without the first patch, the open fds get confused and
> rpc.mountd doesn't listen on all /proc/net/rpc/*/channel
> properly and nfs doesn't work.
> 
> Thanks,
> NeilBrown
> 
> ---
> 
> NeilBrown (3):
>       mountd: Initialize logging early.
>       conffile: allow optional include files.
>       statd: take user-id from /var/lib/nfs/sm
Committed... 

steved.
> 
> 
>  support/nfs/conffile.c    |   13 ++++++++++---
>  support/nsm/file.c        |   16 +++++-----------
>  systemd/nfs.conf.man      |    3 +++
>  utils/mountd/mountd.c     |    9 +++------
>  utils/statd/sm-notify.man |   10 +++++++++-
>  utils/statd/statd.man     |   10 +++++++++-
>  6 files changed, 39 insertions(+), 22 deletions(-)
> 
> --
> Signature
> 
