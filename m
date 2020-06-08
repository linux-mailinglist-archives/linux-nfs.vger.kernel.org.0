Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1851F216D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFHVTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 17:19:45 -0400
Received: from fieldses.org ([173.255.197.46]:34790 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgFHVTp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Jun 2020 17:19:45 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 08FDB878C; Mon,  8 Jun 2020 17:19:45 -0400 (EDT)
Date:   Mon, 8 Jun 2020 17:19:45 -0400
To:     linux-nfs@vger.kernel.org
Subject: client caching and locks
Message-ID: <20200608211945.GB30639@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

What does the client do to its cache when it writes to a locked range?

The RFC:

	https://tools.ietf.org/html/rfc7530#section-10.3.2

seems to apply that you should get something like local-filesystem
semantics if you write-lock any range that you write to and read-lock
any range that you read from.

But I see a report that when applications write to non-overlapping
ranges (while taking locks over those ranges), they don't see each
other's updates.

I think for simultaneous non-overlapping writes to work that way, the
client would need to invalidate its cache on unlock (except for the
locked range).  But i can't tell what the client's designed to do.

--b.
