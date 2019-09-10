Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98579AED8F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfIJOqE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 10:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJOqE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Sep 2019 10:46:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CED0C04B940;
        Tue, 10 Sep 2019 14:46:04 +0000 (UTC)
Received: from ovpn-116-252.phx2.redhat.com (ovpn-116-252.phx2.redhat.com [10.3.116.252])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFECF19C4F;
        Tue, 10 Sep 2019 14:46:03 +0000 (UTC)
Message-ID: <2351c8f2f97d8730fa4fc4e49175b6c42ddb3484.camel@redhat.com>
Subject: Re: [PATCH v2 0/2] add hash of the kerberos principal to the data
 being tracked by nfsdcld
From:   Simo Sorce <simo@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>, bfields@fieldses.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Sep 2019 10:46:02 -0400
In-Reply-To: <20190909201031.12323-1-smayhew@redhat.com>
References: <20190909201031.12323-1-smayhew@redhat.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 10 Sep 2019 14:46:04 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2019-09-09 at 16:10 -0400, Scott Mayhew wrote:
> At the spring bakeathon, Chuck suggested that we should store the
> kerberos principal in addition to the client id string in nfsdcld.  The
> idea is to prevent an illegitimate client from reclaiming another
> client's opens by supplying that client's id string.
> 
> The first patch lays some groundwork for supporting multiple message
> versions for the nfsdcld upcalls, adding fields for version and message
> length to the nfsd4_client_tracking_ops (these fields are only used for
> the nfsdcld upcalls and ignored for the other tracking methods), as well
> as an upcall to get the maximum version supported by the userspace
> daemon.
> 
> The second patch actually adds the v2 message, which adds the sha256 hash
> of the kerberos principal to the Cld_Create upcall and to the Cld_GraceStart
> downcall (which is what loads the data in the reclaim_str_hashtbl).
> 
> Changes since v1:
> - use the sha256 hash of a principal instead of the principal itself
> - prefer the cr_raw_principal (returned by gssproxy) if it exists, then
>   fall back to cr_principal (returned by both gssproxy and rpc.svcgssd)
> 
> Scott Mayhew (2):
>   nfsd: add a "GetVersion" upcall for nfsdcld
>   nfsd: add support for upcall version 2
> 
>  fs/nfsd/nfs4recover.c         | 388 ++++++++++++++++++++++++++++------
>  fs/nfsd/nfs4state.c           |   6 +-
>  fs/nfsd/state.h               |   3 +-
>  include/uapi/linux/nfsd/cld.h |  41 +++-
>  4 files changed, 371 insertions(+), 67 deletions(-)
> 

LGTM.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




