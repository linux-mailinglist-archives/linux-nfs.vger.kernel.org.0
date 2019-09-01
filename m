Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA8A4ADE
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2019 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfIAR0S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Sep 2019 13:26:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39820 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfIAR0R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Sep 2019 13:26:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 84F4C8201F; Sun,  1 Sep 2019 19:26:02 +0200 (CEST)
Date:   Sun, 1 Sep 2019 19:25:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        rjw@rjwysocki.net, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] freezer,NFS: add an unsafe
 schedule_timeout_interruptable freezable helper for NFS
Message-ID: <20190901172559.GF1047@bug>
References: <5fbe3d2c1e83face5c916891ef2823376eec3808.1567092682.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbe3d2c1e83face5c916891ef2823376eec3808.1567092682.git.bcodding@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu 2019-08-29 11:33:37, Benjamin Coddington wrote:
> After commit 0688e64bc600 ("NFS: Allow signal interruption of NFS4ERR_DELAYed
> operations") my NFS client dumps lockdep warnings:
> 
> 	====================================
> 	WARNING: dir_create.sh/1911 still has locks held!
> 
> This patch follows prior art in commit 416ad3c9c006 ("freezer: add unsafe
> versions of freezable helpers for NFS") to skip lock dependency checks for
> NFS.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>


Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
