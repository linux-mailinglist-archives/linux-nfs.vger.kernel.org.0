Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B232D2AA511
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 13:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgKGMti (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Nov 2020 07:49:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgKGMth (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Nov 2020 07:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604753376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziOYjPXhMY0vz23poA//z5BnthtBDtD1PGix2QV23uw=;
        b=Loo2yIVC3z4juviDHSXRvOA8IeiCIf70xhTmXiwPsbJf+bP3ZuIbgqMW8v8ro9RhcL74En
        0F9D4RgC0c9qOUeQ4xXpshaNtDB+9VQrDpzvhft/0WAQKhk1sDAX77GWF+qgHBZjyuU9I1
        E9gI1kfR8vkLsOu2dxmq7Lni2R6jrOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-DONVX6I7PWCGwmmb-xGmYg-1; Sat, 07 Nov 2020 07:49:34 -0500
X-MC-Unique: DONVX6I7PWCGwmmb-xGmYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 381E7107B475;
        Sat,  7 Nov 2020 12:49:33 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F241002C05;
        Sat,  7 Nov 2020 12:49:32 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/17] Readdir enhancements
Date:   Sat, 07 Nov 2020 07:49:31 -0500
Message-ID: <0A45C334-A375-47DC-BA04-F25341F263FA@redhat.com>
In-Reply-To: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Nov 2020, at 11:16, trondmy@gmail.com wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The following patch series performs a number of cleanups on the readdir
> code.
> It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
> the caching code to ensure that we cache the entire contents of that
> 1MB call (instead of discarding the data that doesn't fit into a single
> page).
>
> v2: Fix the handling of the NFSv3/v4 directory verifier
> v3: Optimise searching when the readdir cookies are seen to be ordered

Hi Trond, thanks for these.

I did a bit of testing with these on 4-core/4G client listing 1.5M files
with READDIR.  I compared v5.10-rc2 without/with this set.

+------+     v5.10.rc-2      +--+ this v3 patch set  +
| run  |  time   | rpc calls |  |  time  | rpc calls |

nfsv3 with dtsize 262144:
+------+---------+-----------+--+--------+-----------+
| 1    | 81.583  | 14710     |  | 53.568 | 215       |
| 2    | 81.147  | 14710     |  | 50.781 | 215       |
| 3    | 81.61   | 14710     |  | 50.514 | 215       |
| 4    | 82.405  | 14710     |  | 50.746 | 215       |
| 5    | 82.066  | 14710     |  | 50.397 | 215       |
| 6    | 82.395  | 14710     |  | 50.892 | 215       |
| 7    | 81.657  | 14710     |  | 50.882 | 215       |
| 8    | 81.555  | 14710     |  | 50.981 | 215       |
| 9    | 81.421  | 14710     |  | 50.558 | 215       |
| 10   | 81.472  | 14710     |  | 50.588 | 215       |

nfsv3 with dtsize 1048576:
+------+---------+-----------+--+--------+-----------+
| 1    | 81.563  | 14710     |  | 52.692 | 61        |
| 2    | 82.123  | 14710     |  | 49.934 | 61        |
| 3    | 81.714  | 14710     |  | 50.158 | 61        |
| 4    | 81.707  | 14710     |  | 50.083 | 61        |
| 5    | 81.44   | 14710     |  | 50.045 | 61        |
| 6    | 81.685  | 14710     |  | 50.021 | 61        |
| 7    | 81.17   | 14710     |  | 50.131 | 61        |
| 8    | 81.366  | 14710     |  | 49.928 | 61        |
| 9    | 81.067  | 14710     |  | 50.081 | 61        |
| 10   | 81.524  | 14710     |  | 50.442 | 61        |

nfsv4 with dtsize 32768:
+------+---------+-----------+--+--------+-----------+
| 1    | 99.534  | 14712     |  | 79.461 | 331       |
| 2    | 98.998  | 14712     |  | 79.338 | 331       |
| 3    | 99.462  | 14712     |  | 81.101 | 331       |
| 4    | 99.891  | 14712     |  | 78.888 | 331       |
| 5    | 99.516  | 14712     |  | 81.147 | 331       |
| 6    | 98.649  | 14712     |  | 83.084 | 331       |
| 7    | 101.159 | 14712     |  | 80.461 | 331       |
| 8    | 100.402 | 14712     |  | 79.003 | 331       |
| 9    | 98.548  | 14712     |  | 80.619 | 331       |
| 10   | 97.456  | 14712     |  | 81.317 | 331       |

nfsv4 with dtsize 1048576:
+------+---------+-----------+--+--------+-----------+
| 1    | 100.357 | 14712     |  | 78.976 | 91        |
| 2    | 99.61   | 14712     |  | 79.328 | 91        |
| 3    | 101.095 | 14712     |  | 80.649 | 91        |
| 4    | 107.904 | 14712     |  | 78.285 | 91        |
| 5    | 103.665 | 14712     |  | 79.258 | 91        |
| 6    | 98.877  | 14712     |  | 78.817 | 91        |
| 7    | 99.567  | 14712     |  | 81.11  | 91        |
| 8    | 99.096  | 14712     |  | 80.296 | 91        |
| 9    | 100.124 | 14712     |  | 78.865 | 91        |
| 10   | 100.603 | 14712     |  | 79.143 | 91        |

These look great.  Feel free to add either/both of my:
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>

Ben

