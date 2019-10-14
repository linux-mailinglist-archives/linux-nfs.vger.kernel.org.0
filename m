Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A6D690D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2019 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfJNSDO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Oct 2019 14:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbfJNSDO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Oct 2019 14:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C75B485A07
        for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2019 18:03:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-253.phx2.redhat.com [10.3.116.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FF0D60126;
        Mon, 14 Oct 2019 18:03:13 +0000 (UTC)
Subject: Re: [nfs-utils PATCH v3 0/4] add hash of the kerberos principal to
 the data being tracked by nfsdcld
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190910145003.4165-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <2a5089c8-5611-8867-b203-707bf93d6435@RedHat.com>
Date:   Mon, 14 Oct 2019 14:03:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190910145003.4165-1-smayhew@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 14 Oct 2019 18:03:13 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/10/19 10:49 AM, Scott Mayhew wrote:
> At the spring bakeathon, Chuck suggested that we should store the
> kerberos principal in addition to the client id string in nfsdcld.  The
> idea is to prevent an illegitimate client from reclaiming another
> client's opens by supplying that client's id string.
> 
> The first patch adds support for a "GetVersion" upcall which allows nfsd
> to determine the maximum message version that nfsdcld supports.  Right
> now it's based on the value of CLD_UPCALL_VERSION from cld.h, but I was
> thinking we may wish to add a command-line option (and an nfs.conf)
> option to make it possible to use a lower version than
> CLD_UPCALL_VERSION.  My thinking here is that an older nfsdcld daemon
> won't be compatible with the new database schema... rather than worrying
> about messing with downgrading the database, just use the command-line
> option to make it behave like an older daemon.
> 
> The second patch adds handling for the v2 Cld_Create and Cld_GraceStart
> upcalls, which can include a hash of the kerberos principal which we'll
> store along with the client id string in the database.  Note that if we're
> talking to an old kernel that does the v1 upcall, everything still works
> (we just ignore the new columns in the database).
> 
> The third patch adds a tool for manipulating nfsdcld's database schema.
> It's mostly intended to be used to downgrade the database in the
> (hopefully rare) event that an admin would want to downgrade nfsdcld.
> It also provides the ability for fixing broken recovery table names
> (which nfsdcld also fixes automatically) as well as the ability to print
> the contents of the database.
> 
> The final patch updates the nfsdcld man page.
> 
> Changes since v2:
> - we're storing a sha256 hash of a principal instead of the principal
>   itself
> 
> Changes since v1:
> - added a tool for manipulating nfsdcld's sqlite database schema
> - updated the nfsdcld man page
> 
> Scott Mayhew (4):
>   nfsdcld: add a "GetVersion" upcall
>   nfsdcld: add support for upcall version 2
>   Add a tool for manipulating the nfsdcld sqlite database schema.
>   nfsdcld: update nfsdcld.man
Committed.... 

steved.

> 
>  configure.ac                    |   1 +
>  support/include/cld.h           |  41 ++++-
>  tools/Makefile.am               |   4 +
>  tools/clddb-tool/Makefile.am    |  13 ++
>  tools/clddb-tool/clddb-tool.man |  83 ++++++++++
>  tools/clddb-tool/clddb-tool.py  | 266 ++++++++++++++++++++++++++++++++
>  utils/nfsdcld/cld-internal.h    |  13 +-
>  utils/nfsdcld/nfsdcld.c         | 140 ++++++++++++++---
>  utils/nfsdcld/nfsdcld.man       |  32 +++-
>  utils/nfsdcld/sqlite.c          | 239 +++++++++++++++++++++++-----
>  utils/nfsdcld/sqlite.h          |   2 +
>  11 files changed, 765 insertions(+), 69 deletions(-)
>  create mode 100644 tools/clddb-tool/Makefile.am
>  create mode 100644 tools/clddb-tool/clddb-tool.man
>  create mode 100644 tools/clddb-tool/clddb-tool.py
> 
