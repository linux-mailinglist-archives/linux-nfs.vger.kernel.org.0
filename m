Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3138145A88
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgAVREC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 12:04:02 -0500
Received: from fieldses.org ([173.255.197.46]:38416 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgAVREC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Jan 2020 12:04:02 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id EC9AF1C89; Wed, 22 Jan 2020 12:04:01 -0500 (EST)
Date:   Wed, 22 Jan 2020 12:04:01 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Fix error reporting for NFS writes
Message-ID: <20200122170401.GA3720@fieldses.org>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200122152751.GD2654@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122152751.GD2654@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 22, 2020 at 10:27:51AM -0500, bfields wrote:
> By the way, anyone know how to handle quoted-printable patches?
> 
> For some reason, git-am seems to deal with them, but git-apply doesn't.
> So it's fine until there's some minor conflict.

(Ended up running them through "tcucodec quote -d".  Maybe there's some
more obvious solution.)

--b.
