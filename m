Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489BF2155A7
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 12:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgGFKe2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgGFKe2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 06:34:28 -0400
Received: from mail.sernet.de (mail.sernet.de [IPv6:2a0a:a3c0:0:25::217:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD779C061794
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 03:34:27 -0700 (PDT)
Received: from intern.sernet.de by mail.sernet.de
        with esmtps (Exim 4.92 #3)
        id 1jsO3L-0005un-V8; Mon, 06 Jul 2020 12:08:47 +0200
Received: by intern.sernet.de
        id 1jsO3L-00060a-R6; Mon, 06 Jul 2020 12:08:47 +0200
Received: from bjacke by pell.sernet.de with local (Exim 4.93)
        (envelope-from <bjacke@sernet.de>)
        id 1jsO3L-0061rY-Mj; Mon, 06 Jul 2020 12:08:47 +0200
Date:   Mon, 6 Jul 2020 12:08:47 +0200
From:   =?iso-8859-1?Q?Bj=F6rn?= JACKE <bj@SerNet.DE>
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "samba@lists.samba.org" <samba@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [Samba] Multiprotocol File Sharing via NFSv4 and Samba
Message-ID: <20200706100847.GE1431317@sernet.de>
Mail-Followup-To: "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "samba@lists.samba.org" <samba@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
X-Q:    Die Schriftsteller koennen nicht so schnell schreiben, wie die
 Regierungen Kriege machen; denn das Schreiben verlangt Denkarbeit. - Brecht
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-02 at 18:04 +0000 Kraus, Sebastian via samba sent off:
> are there any non-commercial solutions (apart from solutions like Dell EMC, IBM and NetApp) around that allow to simultaneously access the same file system via NFSv4 and Samba exports in a (nearly) non-conflicting manner, especially w.r.t. to NFSv4/Windows ACL incompatibilities?

related to this topic the NFS4 ACL overview in the wiki:
https://wiki.samba.org/index.php/NFS4_ACL_overview

Björn
