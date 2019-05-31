Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00F53163C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEaUjo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 16:39:44 -0400
Received: from fieldses.org ([173.255.197.46]:42596 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfEaUjo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 May 2019 16:39:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0687D37E; Fri, 31 May 2019 16:39:44 -0400 (EDT)
Date:   Fri, 31 May 2019 16:39:44 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] nfsd bugfix for 5.2
Message-ID: <20190531203944.GB5334@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-1

This reverts a minor fix which could cause us to treat conflicting NLM
locks as nonconflicting.

We have proper fix queued up for 5.3.  In the meantime, a quick revert
seems best for 5.2 and stable.

--b.

Benjamin Coddington (1):
      Revert "lockd: Show pid of lockd for remote locks"

 fs/lockd/xdr.c  | 4 ++--
 fs/lockd/xdr4.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
