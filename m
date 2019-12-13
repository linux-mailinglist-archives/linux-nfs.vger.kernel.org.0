Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A615B11E54C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLMOLL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 09:11:11 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfLMOLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 09:11:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MqatE-1htFYF0ymW-00mcAo; Fri, 13 Dec 2019 15:10:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 00/12] nfsd: avoid 32-bit time_t
Date:   Fri, 13 Dec 2019 15:10:34 +0100
Message-Id: <20191213141046.1770441-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+0lf7quhBTwr1hQIQfFsZXCeV8kC+cPWtTWgqbymNABPk3abhSO
 NGcTswDiRg6NEXlWr/qKPkMTB+BZ7N4mAys245gZU6NRMDRj02KaTEN5pmlfFTWrKjNH8oh
 OEHu5iwTenlUX1zqeFlO/jJ/Xwa+puWPcoKC475ZvukPVgMfsCarKZg8fQ1xgh7oaXBYEZb
 53++FXmqE/BaaFQgZ637w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kl2yuRnl85w=:Q5K7j2VJHzNXxSbQSrNSby
 SGlvYHGPH1AgusfKY+VgepU4tOw3M3/Oj1kAwlqsexgzKkg0jJDwuaeVKr2G+5pCvhMBfBD9E
 Qzp8AI6zUehUMF7Eho3xPRPO22b08fIamGIYuT5QgjLyyy8p7OxEfqL5becxXLQzTJDJsNPST
 aSBaX4fBHwG83S+YQQgxZf9LltmaJCZ1IRz4cJU41jQ2ZbXmgcA+/NcJ4qG6l7a0HoGvnPulS
 YIz2rOhwuAxsP0WkoHbeNVxmR0Qk6PFoFvaJ2J9Y52UcEn1CJKi14DnhIfhODEypw1qHvY08t
 TiooS8HXj8pNvTxCx39/FUrZrrhNSq80LVhiJ/O6bqz+zkT50HFzOJEfigDhfIf0sBSknmK3w
 QBmHUyarHOWV/0zH6TOrXBoOvGw9HiSTNbg7f8m8TX+yfyMBr98t2NPhhzH45YLjXHeQT4xGS
 ltbc3XHUOPj4Bw/2C9qy1ShSr1T/LbtgW4RukKODymSOWCuT1DnlHlM1LW0XFBf28qrDQbQhK
 ZI8n3cEjulBu8rxip7ASwXmz44EH60PwhZydyntuyO63WWV6wdzRFTFyMEH4x/zB6CyL4Dm3q
 jZAIBqIFtBrlpS0W0Zq6NTemkm9Qza3DPBoH7pByB+1J35IfKnIFA6wjrWk2+sluEW63xetgZ
 sXv2TbOPS/b1rsbJUUyiykH5v1tsFXdXj6O1yDt+l/yCy5/3GD/xdVTZ6nGkwVE64pvq4+53t
 tU/oHaTE4M7IV64zrd5PPIHgFQyfyIDzEVvlVhDTYvE7JjTClHBzt2rrqqfD4SsYPgZ4XE/HJ
 DUdUaBaU385Omvxnx5AU63RnxIuYIeLFN5kWO0zGYJbcBVVNzG2vjs6XWFzpnf+r8W8DHEd5j
 pFV7EuP33kJdIphbN33Q==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce, Chuck,

NFSd is one of the last areas of the kernel that is not y2038 safe
yet, this series addresses the remaining issues here.

I did not get any comments for the first version I posted [1], and
I hope this just means that everything was fine and you plan to
merge this soon ;-)

I uploaded a git branch to [2] for testing.

Please review and merge for linux-5.6 so we can remove the 32-bit
time handling from that release.

      Arnd

Changes from v1:
- separate nfs and nfsd, as most of the nfs changes are merged now
- rebase to v5.5

[1] https://lore.kernel.org/lkml/20191111201639.2240623-1-arnd@arndb.de/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-nfsd

Arnd Bergmann (12):
  nfsd: use ktime_get_seconds() for timestamps
  nfsd: print 64-bit timestamps in client_info_show
  nfsd: handle nfs3 timestamps as unsigned
  nfsd: use timespec64 in encode_time_delta
  nfsd: make 'boot_time' 64-bit wide
  nfsd: pass a 64-bit guardtime to nfsd_setattr()
  nfsd: use time64_t in nfsd_proc_setattr() check
  nfsd: fix delay timer on 32-bit architectures
  nfsd: fix jiffies/time_t mixup in LRU list
  nfsd: use boottime for lease expiry alculation
  nfsd: use ktime_get_real_seconds() in nfs4_verifier
  nfsd: remove nfs4_reset_lease() declarations

 fs/nfsd/netns.h        |  6 ++--
 fs/nfsd/nfs3xdr.c      | 20 +++++--------
 fs/nfsd/nfs4callback.c |  7 ++++-
 fs/nfsd/nfs4layouts.c  |  2 +-
 fs/nfsd/nfs4proc.c     |  2 +-
 fs/nfsd/nfs4recover.c  |  8 ++---
 fs/nfsd/nfs4state.c    | 68 ++++++++++++++++++++----------------------
 fs/nfsd/nfs4xdr.c      |  4 +--
 fs/nfsd/nfsctl.c       |  6 ++--
 fs/nfsd/nfsd.h         |  2 --
 fs/nfsd/nfsfh.h        |  4 +--
 fs/nfsd/nfsproc.c      |  6 ++--
 fs/nfsd/state.h        | 10 +++----
 fs/nfsd/vfs.c          |  4 +--
 fs/nfsd/vfs.h          |  2 +-
 fs/nfsd/xdr3.h         |  2 +-
 16 files changed, 74 insertions(+), 79 deletions(-)

-- 
2.20.0

