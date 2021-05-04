Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ED33724B9
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhEDDfl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 3 May 2021 23:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhEDDfl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 23:35:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27D28B14E;
        Tue,  4 May 2021 03:34:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Yongcheng Yang" <yoyang@redhat.com>
Cc:     "Steve Dickson" <steved@redhat.com>
Cc:     "Linux NFS Mailing list" <linux-nfs@vger.kernel.org>,
        "Yongcheng Yang" <yoyang@redhat.com>,
        "Petr Pisar" <ppisar@redhat.com>
Subject: Re: [PATCH] systemd: nfs-server.service add "Wants" dependency on
 rpc-rquotad.service
In-reply-to: <20210430065601.16523-1-yoyang@redhat.com>
References: <20210430065601.16523-1-yoyang@redhat.com>
Date:   Tue, 04 May 2021 13:34:41 +1000
Message-id: <162009928153.6582.2032158868104502300@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 30 Apr 2021, Yongcheng Yang wrote:
> The RPC quota service was part of nfs-utils and started together
> with nfs-server before it was splitting out from nfs-utils.
> 
> It would be convenient to preserve the behavior: Let nfs-server
> start rpc-rquotad automatically.
> 
> Signed-off-by: Petr Pisar <ppisar@redhat.com>
> Signed-off-by: Yongcheng Yang <yoyang@redhat.com>

I would prefer that whatever package provides rpc-rquotad should take
care of this.
It can provide a "wants" symlink

  .../systemd/system/nfs-server.wants/rpc-rquotad.service -> .../rpc-rquotad.service

NeilBrown
