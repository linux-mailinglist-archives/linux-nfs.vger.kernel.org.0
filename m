Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07B459E9
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFNKGr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 06:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFNKGr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 Jun 2019 06:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 630E3859FC;
        Fri, 14 Jun 2019 10:06:46 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F19CB5D9C3;
        Fri, 14 Jun 2019 10:06:44 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Goetz, Patrick G" <pgoetz@math.utexas.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Can we setup pNFS with multiple DSs ?
Date:   Fri, 14 Jun 2019 06:06:45 -0400
Message-ID: <30177AD3-E601-44AA-9BA7-434933ABD7B1@redhat.com>
In-Reply-To: <5e952e34-bc60-c63d-54c2-d0ae72301a86@math.utexas.edu>
References: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
 <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
 <5e952e34-bc60-c63d-54c2-d0ae72301a86@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 14 Jun 2019 10:06:46 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Jun 2019, at 11:30, Goetz, Patrick G wrote:

> Every so often I hunt for documentation on how to set up pNFS and can
> never find anything.  Can someone point me to something that I can use
> to test this myself?

The file Documentation/filesystems/nfs/pnfs-scsi-server.txt in the 
kernel
source tree is probably the best source of current documentation, if 
very
concise:

     pNFS SCSI layout server user guide
     ==================================

     This document describes support for pNFS SCSI layouts in the Linux 
NFS
     server.  With pNFS SCSI layouts, the NFS server acts as Metadata 
Server
     (MDS) for pNFS, which in addition to handling all the metadata 
access to the
     NFS export, also hands out layouts to the clients so that they can 
directly
     access the underlying SCSI LUNs that are shared with the client.

     To use pNFS SCSI layouts with with the Linux NFS server, the 
exported file
     system needs to support the pNFS SCSI layouts (currently just XFS), 
and the
     file system must sit on a SCSI LUN that is accessible to the 
clients in
     addition to the MDS.  As of now the file system needs to sit 
directly on the
     exported LUN, striping or concatenation of LUNs on the MDS and 
clients is
     not supported yet.

     On a server built with CONFIG_NFSD_SCSI, the pNFS SCSI volume 
support is
     automatically enabled if the file system is exported using the 
"pnfs" option
     and the underlying SCSI device support persistent reservations.  On 
the
     client make sure the kernel has the CONFIG_PNFS_BLOCK option 
enabled, and
     the file system is mounted using the NFSv4.1 protocol version 
(mount -o
     vers=4.1).

Should we have more than this?

Ben
