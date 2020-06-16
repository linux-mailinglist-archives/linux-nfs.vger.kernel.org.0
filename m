Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216C1FA5CC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 03:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFPB5m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 21:57:42 -0400
Received: from mailhost.m5p.com ([74.104.188.4]:58269 "EHLO mailhost.m5p.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgFPB5l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Jun 2020 21:57:41 -0400
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.15.2/8.15.2) with ESMTPS id 05G1vLbi081450
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 15 Jun 2020 21:57:27 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.15.2/8.15.2/Submit) id 05G1vK5d081449;
        Mon, 15 Jun 2020 18:57:20 -0700 (PDT)
        (envelope-from ehem)
Date:   Mon, 15 Jun 2020 18:57:20 -0700
From:   Elliott Mitchell <ehem+debian@m5p.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported ZFS
 (with acltype=off) (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200616015720.GA81232@mattapan.m5p.com>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615145035.GA214986@pick.fieldses.org>
X-Spam-Status: No, score=0.4 required=10.0 tests=KHOP_HELO_FCRDNS autolearn=no
        autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mattapan.m5p.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 15, 2020 at 10:50:35AM -0400, J. Bruce Fields wrote:
> Honestly I don't think I currently have a regression test for this so
> it's possible I could have missed something upstream.  I haven't seen
> any reports, though....
> 
> ZFS's ACL implementation is very different from any in-tree
> filesystem's, and given limited time, a filesystem with no prospect of
> going upstream isn't going to get much attention, so, yes, I'd need to
> see a reproducer on xfs or ext4 or something.

Salvatore managing to reproduce it with ext4 yet all prior reports with
the filesystem used being known was ZFS seems to suggest one of two
things.

First, could be enabling POSIX ACLs has been very strongly pushed by
other filesystems, while ZFS hasn't pushed them as strongly.

Second, could be a substantial majority of users of NFS are using ZFS.

If the former, this simply means an additional test case is needed.  If
the latter, then any testing of NFS which excludes ZFS is going to have
underwhelming coverage.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


