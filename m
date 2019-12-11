Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE1811BDFA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfLKUdK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Dec 2019 15:33:10 -0500
Received: from fieldses.org ([173.255.197.46]:58766 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfLKUdK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Dec 2019 15:33:10 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 41D1F1C7C; Wed, 11 Dec 2019 15:33:10 -0500 (EST)
Date:   Wed, 11 Dec 2019 15:33:10 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alex Lyakas <alex@zadara.com>
Cc:     linux-nfs@vger.kernel.org, Shyam Kaushik <shyam@zadara.com>
Subject: Re: [PATCH v2] nfsd: provide a procfs entry to release stateids of a
 particular local filesystem
Message-ID: <20191211203310.GA21338@fieldses.org>
References: <1568142147-21974-1-git-send-email-alex@zadara.com>
 <20191205160015.GC22402@fieldses.org>
 <CAOcd+r272sRYo==owcG90WT3MwrqWXJkSu7UADegmfPQWG2K3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r272sRYo==owcG90WT3MwrqWXJkSu7UADegmfPQWG2K3A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Dec 08, 2019 at 10:41:29AM +0200, Alex Lyakas wrote:
> Bottom line this issue happens to us in production, and it would be
> good for us to have it resolved. With our limited nfsd understanding,
> do you believe anybody from the community could help?

Yes: congratulations, you're a member of the community, and you can
help!

I'm afraid we've all got a lot on our plates.  This is on my list, but I
doubt I'll get to it in the next year.

--b.
