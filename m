Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796D9146386
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWIc0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 03:32:26 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33105 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAWIcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jan 2020 03:32:25 -0500
Received: by mail-pg1-f172.google.com with SMTP id 6so1028293pgk.0;
        Thu, 23 Jan 2020 00:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=y+mc/TstohUCOskljmnHs0PFiH97g8D+ANpc7ipPI/g=;
        b=f5ragx0/QKhVxZBCfS9ak32vYU04qyDOE1OmbSYRoNYsTlOv1JjuFCmvSMp0nG4yWY
         FQCCFMsxGr1mmrjeZGd/WgQ3PU6fHHUdBxTQxRMqtI1cieP9SY91RW6Z2ztxDF8YDIb4
         1IReGCgsIW3HE6/yQDrvnBf+cCYHlLvl9puJ5W7l9HkcZ4b9HZraWFMCEM9bnbSugqJa
         00aBgFW0ylTmF+qBkmgXJyedi90WS8x1tpiF2iBomdPsMH8eHTeV4C5SIs1vGhj73+d8
         EHML0/uv3G60qMsckNVFT8QF+xfsb8/ZdDlBwYoA0wsBjEOMPE2v5+TZfmB0LreGKD18
         HDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=y+mc/TstohUCOskljmnHs0PFiH97g8D+ANpc7ipPI/g=;
        b=tfxNrUNuOOA3YuJm8IQOKmPFlMIivIrJ4D4hpQ0SUPqI8ABPkabNAL7viIDHRYnKe6
         J+0oHn8cGbBPwKpeau0ohI0GG9XSvEqd/6YcPjR9rw2Ifdk4XM+/bphTM6NxhD+PLViC
         28+uV0T9WsdjLmfT8bKwq0OhR7dn/RLq7fFW8n7HcXJIkU/4JvdsOYTigBt5VxJWyM6p
         CrieDvcr6+Rpw0lPtNlEsopXmsGbFLIo4hoYVjhGR2CaKPJQRKUgvCSs605ADj2ZzlG4
         w7DmMxcxkMhpqS1SpzLfXZxsYOmIZfzMMp0ltDhmIIfxLPqzq8N/d64OvbGIAJH1YIVC
         uKQw==
X-Gm-Message-State: APjAAAV+XatYUsVVIKAE4PUB7otAeFmSJ50yVp6X36YQ885AEPW9zc+O
        opNkCalfh7xsoaBlcierXf7WmKp+
X-Google-Smtp-Source: APXvYqxucKOEZVH2AQKvSdN2olVXGbD5e+Mkt/eDHaGmWam7pW6ZoexJAO8gBejobgDkunC5r3QUDA==
X-Received: by 2002:a63:3d4:: with SMTP id 203mr2691303pgd.266.1579768344831;
        Thu, 23 Jan 2020 00:32:24 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 81sm1659676pfx.30.2020.01.23.00.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 00:32:24 -0800 (PST)
Date:   Thu, 23 Jan 2020 16:32:17 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: A NFS, xfs, reflink and rmapbt story
Message-ID: <20200123083217.flkl6tkyr4b7zwuk@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Deleting the files left by generic/175 costs too much time when testing
on NFSv4.2 exporting xfs with rmapbt=1.

"./check -nfs generic/175 generic/176" should reproduce it.

My test bed is a 16c8G vm.

NFSv4.2  rmapbt=1   24h+
NFSv4.2  rmapbt=0   1h-2h
xfs      rmapbt=1   10m+

At first I thought it hung, turns out it was just slow when deleting
2 massive reflined files.

It's reproducible using latest Linus tree, and Darrick's deferred-inactivation
branch. Run latest for-next branch xfsprogs.

I'm not sure it's something wrong, just sharing with you guys. I don't
remember I have identified this as a regression. It should be there for
a long time.

Sending to xfs and nfs because it looks like all related. :)

This almost gets lost in my list. Not much information recorded, some
trace-cmd outputs for your info. It's easy to reproduce. If it's
interesting to you and need any info, feel free to ask.

Thanks,


7)   0.279 us    |  xfs_btree_get_block [xfs]();
7)   0.303 us    |  xfs_btree_rec_offset [xfs]();
7)   0.301 us    |  xfs_rmapbt_init_high_key_from_rec [xfs]();
7)   0.356 us    |  xfs_rmapbt_diff_two_keys [xfs]();
7)   0.305 us    |  xfs_rmapbt_init_key_from_rec [xfs]();
7)   0.306 us    |  xfs_rmapbt_diff_two_keys [xfs]();
7)               |  xfs_rmap_query_range_helper [xfs]() {
7)   0.279 us    |    xfs_rmap_btrec_to_irec [xfs]();
7)               |    xfs_rmap_lookup_le_range_helper [xfs]() {
1)   0.786 us    |  _raw_spin_lock_irqsave();
7)               |      /* xfs_rmap_lookup_le_range_candidate: dev 8:34 agno 2 agbno 6416 len 256 owner 67160161 offset 99284480 flags 0x0 */
7)   0.506 us    |    }
7)   1.680 us    |  }
