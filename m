Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5619443829
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 23:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhKBWEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhKBWEy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 18:04:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AEFC061203;
        Tue,  2 Nov 2021 15:02:18 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 685CD5EC8;
        Tue,  2 Nov 2021 22:02:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 685CD5EC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890538; bh=zbsiGWfqK5orLR+KEARR8fWOciWx/3Xh24nN8dCoJio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3QxIJTlSxQf1HMp52NCWYPqZabAXtmXXqPjQMLqyRYggLv0blqHN/a4EfBqPpeUV
         5FjfP/fH0MymT6HMMKUvjnu1H3X97SrdsrQeKx++F7Wj+Lp56vvIaDlWMc+gYOChHH
         /zLWuOMnt2Uj9i4SndQ2+YV+QRGfr2xY5PVazZcU4SHZbOJdgaH0Y0q/zFulrvUCyF
         24yl1E65B1rW9870yCxY8mPD1YNX905YWBMiEsYJ52Wa2x+MJdFosYjmdCMOOlq4hc
         cxNHdhN1t60LMHU8T+X0v4hH33SUQ0H8ROnr3sUa2aqhahcNslB4iOheIkZqQP+Xt6
         Yn4oPh0DwX5BQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH 2/9] nfs: remove unused header <linux/pnfs_osd_xdr.h>
Date:   Tue,  2 Nov 2021 16:01:56 -0600
Message-Id: <20211102220203.940290-3-corbet@lwn.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102220203.940290-1-corbet@lwn.net>
References: <20211102220203.940290-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 19fcae3d4f2dd ("scsi: remove the SCSI OSD library") deleted the last
file that included <linux/pnfs_osd_xdr.h> but left that file behind.  It's
unused, get rid of it now.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/pnfs_osd_xdr.h | 317 -----------------------------------
 1 file changed, 317 deletions(-)
 delete mode 100644 include/linux/pnfs_osd_xdr.h

diff --git a/include/linux/pnfs_osd_xdr.h b/include/linux/pnfs_osd_xdr.h
deleted file mode 100644
index 17d7d0d20eca..000000000000
--- a/include/linux/pnfs_osd_xdr.h
+++ /dev/null
@@ -1,317 +0,0 @@
-/*
- *  pNFS-osd on-the-wire data structures
- *
- *  Copyright (C) 2007 Panasas Inc. [year of first publication]
- *  All rights reserved.
- *
- *  Benny Halevy <bhalevy@panasas.com>
- *  Boaz Harrosh <ooo@electrozaur.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  See the file COPYING included with this distribution for more details.
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *
- *  1. Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *  2. Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in the
- *     documentation and/or other materials provided with the distribution.
- *  3. Neither the name of the Panasas company nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- *  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
- *  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- *  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-#ifndef __PNFS_OSD_XDR_H__
-#define __PNFS_OSD_XDR_H__
-
-#include <linux/nfs_fs.h>
-
-/*
- * draft-ietf-nfsv4-minorversion-22
- * draft-ietf-nfsv4-pnfs-obj-12
- */
-
-/* Layout Structure */
-
-enum pnfs_osd_raid_algorithm4 {
-	PNFS_OSD_RAID_0		= 1,
-	PNFS_OSD_RAID_4		= 2,
-	PNFS_OSD_RAID_5		= 3,
-	PNFS_OSD_RAID_PQ	= 4     /* Reed-Solomon P+Q */
-};
-
-/*   struct pnfs_osd_data_map4 {
- *       uint32_t                    odm_num_comps;
- *       length4                     odm_stripe_unit;
- *       uint32_t                    odm_group_width;
- *       uint32_t                    odm_group_depth;
- *       uint32_t                    odm_mirror_cnt;
- *       pnfs_osd_raid_algorithm4    odm_raid_algorithm;
- *   };
- */
-struct pnfs_osd_data_map {
-	u32	odm_num_comps;
-	u64	odm_stripe_unit;
-	u32	odm_group_width;
-	u32	odm_group_depth;
-	u32	odm_mirror_cnt;
-	u32	odm_raid_algorithm;
-};
-
-/*   struct pnfs_osd_objid4 {
- *       deviceid4       oid_device_id;
- *       uint64_t        oid_partition_id;
- *       uint64_t        oid_object_id;
- *   };
- */
-struct pnfs_osd_objid {
-	struct nfs4_deviceid	oid_device_id;
-	u64			oid_partition_id;
-	u64			oid_object_id;
-};
-
-/* For printout. I use:
- * kprint("dev(%llx:%llx)", _DEVID_LO(pointer), _DEVID_HI(pointer));
- * BE style
- */
-#define _DEVID_LO(oid_device_id) \
-	(unsigned long long)be64_to_cpup((__be64 *)(oid_device_id)->data)
-
-#define _DEVID_HI(oid_device_id) \
-	(unsigned long long)be64_to_cpup(((__be64 *)(oid_device_id)->data) + 1)
-
-enum pnfs_osd_version {
-	PNFS_OSD_MISSING              = 0,
-	PNFS_OSD_VERSION_1            = 1,
-	PNFS_OSD_VERSION_2            = 2
-};
-
-struct pnfs_osd_opaque_cred {
-	u32 cred_len;
-	void *cred;
-};
-
-enum pnfs_osd_cap_key_sec {
-	PNFS_OSD_CAP_KEY_SEC_NONE     = 0,
-	PNFS_OSD_CAP_KEY_SEC_SSV      = 1,
-};
-
-/*   struct pnfs_osd_object_cred4 {
- *       pnfs_osd_objid4         oc_object_id;
- *       pnfs_osd_version4       oc_osd_version;
- *       pnfs_osd_cap_key_sec4   oc_cap_key_sec;
- *       opaque                  oc_capability_key<>;
- *       opaque                  oc_capability<>;
- *   };
- */
-struct pnfs_osd_object_cred {
-	struct pnfs_osd_objid		oc_object_id;
-	u32				oc_osd_version;
-	u32				oc_cap_key_sec;
-	struct pnfs_osd_opaque_cred	oc_cap_key;
-	struct pnfs_osd_opaque_cred	oc_cap;
-};
-
-/*   struct pnfs_osd_layout4 {
- *       pnfs_osd_data_map4      olo_map;
- *       uint32_t                olo_comps_index;
- *       pnfs_osd_object_cred4   olo_components<>;
- *   };
- */
-struct pnfs_osd_layout {
-	struct pnfs_osd_data_map	olo_map;
-	u32				olo_comps_index;
-	u32				olo_num_comps;
-	struct pnfs_osd_object_cred	*olo_comps;
-};
-
-/* Device Address */
-enum pnfs_osd_targetid_type {
-	OBJ_TARGET_ANON = 1,
-	OBJ_TARGET_SCSI_NAME = 2,
-	OBJ_TARGET_SCSI_DEVICE_ID = 3,
-};
-
-/*   union pnfs_osd_targetid4 switch (pnfs_osd_targetid_type4 oti_type) {
- *       case OBJ_TARGET_SCSI_NAME:
- *           string              oti_scsi_name<>;
- *
- *       case OBJ_TARGET_SCSI_DEVICE_ID:
- *           opaque              oti_scsi_device_id<>;
- *
- *       default:
- *           void;
- *   };
- *
- *   union pnfs_osd_targetaddr4 switch (bool ota_available) {
- *       case TRUE:
- *           netaddr4            ota_netaddr;
- *       case FALSE:
- *           void;
- *   };
- *
- *   struct pnfs_osd_deviceaddr4 {
- *       pnfs_osd_targetid4      oda_targetid;
- *       pnfs_osd_targetaddr4    oda_targetaddr;
- *       uint64_t                oda_lun;
- *       opaque                  oda_systemid<>;
- *       pnfs_osd_object_cred4   oda_root_obj_cred;
- *       opaque                  oda_osdname<>;
- *   };
- */
-struct pnfs_osd_targetid {
-	u32				oti_type;
-	struct nfs4_string		oti_scsi_device_id;
-};
-
-/*   struct netaddr4 {
- *       // see struct rpcb in RFC1833
- *       string r_netid<>;    // network id
- *       string r_addr<>;     // universal address
- *   };
- */
-struct pnfs_osd_net_addr {
-	struct nfs4_string	r_netid;
-	struct nfs4_string	r_addr;
-};
-
-struct pnfs_osd_targetaddr {
-	u32				ota_available;
-	struct pnfs_osd_net_addr	ota_netaddr;
-};
-
-struct pnfs_osd_deviceaddr {
-	struct pnfs_osd_targetid	oda_targetid;
-	struct pnfs_osd_targetaddr	oda_targetaddr;
-	u8				oda_lun[8];
-	struct nfs4_string		oda_systemid;
-	struct pnfs_osd_object_cred	oda_root_obj_cred;
-	struct nfs4_string		oda_osdname;
-};
-
-/* LAYOUTCOMMIT: layoutupdate */
-
-/*   union pnfs_osd_deltaspaceused4 switch (bool dsu_valid) {
- *       case TRUE:
- *           int64_t     dsu_delta;
- *       case FALSE:
- *           void;
- *   };
- *
- *   struct pnfs_osd_layoutupdate4 {
- *       pnfs_osd_deltaspaceused4    olu_delta_space_used;
- *       bool                        olu_ioerr_flag;
- *   };
- */
-struct pnfs_osd_layoutupdate {
-	u32	dsu_valid;
-	s64	dsu_delta;
-	u32	olu_ioerr_flag;
-};
-
-/* LAYOUTRETURN: I/O Rrror Report */
-
-enum pnfs_osd_errno {
-	PNFS_OSD_ERR_EIO		= 1,
-	PNFS_OSD_ERR_NOT_FOUND		= 2,
-	PNFS_OSD_ERR_NO_SPACE		= 3,
-	PNFS_OSD_ERR_BAD_CRED		= 4,
-	PNFS_OSD_ERR_NO_ACCESS		= 5,
-	PNFS_OSD_ERR_UNREACHABLE	= 6,
-	PNFS_OSD_ERR_RESOURCE		= 7
-};
-
-/*   struct pnfs_osd_ioerr4 {
- *       pnfs_osd_objid4     oer_component;
- *       length4             oer_comp_offset;
- *       length4             oer_comp_length;
- *       bool                oer_iswrite;
- *       pnfs_osd_errno4     oer_errno;
- *   };
- */
-struct pnfs_osd_ioerr {
-	struct pnfs_osd_objid	oer_component;
-	u64			oer_comp_offset;
-	u64			oer_comp_length;
-	u32			oer_iswrite;
-	u32			oer_errno;
-};
-
-/* OSD XDR Client API */
-/* Layout helpers */
-/* Layout decoding is done in two parts:
- * 1. First Call pnfs_osd_xdr_decode_layout_map to read in only the header part
- *    of the layout. @iter members need not be initialized.
- *    Returned:
- *             @layout members are set. (@layout->olo_comps set to NULL).
- *
- *             Zero on success, or negative error if passed xdr is broken.
- *
- * 2. 2nd Call pnfs_osd_xdr_decode_layout_comp() in a loop until it returns
- *    false, to decode the next component.
- *    Returned:
- *       true if there is more to decode or false if we are done or error.
- *
- * Example:
- *	struct pnfs_osd_xdr_decode_layout_iter iter;
- *	struct pnfs_osd_layout layout;
- *	struct pnfs_osd_object_cred comp;
- *	int status;
- *
- *	status = pnfs_osd_xdr_decode_layout_map(&layout, &iter, xdr);
- *	if (unlikely(status))
- *		goto err;
- *	while(pnfs_osd_xdr_decode_layout_comp(&comp, &iter, xdr, &status)) {
- *		// All of @comp strings point to inside the xdr_buffer
- *		// or scrach buffer. Copy them out to user memory eg.
- *		copy_single_comp(dest_comp++, &comp);
- *	}
- *	if (unlikely(status))
- *		goto err;
- */
-
-struct pnfs_osd_xdr_decode_layout_iter {
-	unsigned total_comps;
-	unsigned decoded_comps;
-};
-
-extern int pnfs_osd_xdr_decode_layout_map(struct pnfs_osd_layout *layout,
-	struct pnfs_osd_xdr_decode_layout_iter *iter, struct xdr_stream *xdr);
-
-extern bool pnfs_osd_xdr_decode_layout_comp(struct pnfs_osd_object_cred *comp,
-	struct pnfs_osd_xdr_decode_layout_iter *iter, struct xdr_stream *xdr,
-	int *err);
-
-/* Device Info helpers */
-
-/* Note: All strings inside @deviceaddr point to space inside @p.
- * @p should stay valid while @deviceaddr is in use.
- */
-extern void pnfs_osd_xdr_decode_deviceaddr(
-	struct pnfs_osd_deviceaddr *deviceaddr, __be32 *p);
-
-/* layoutupdate (layout_commit) xdr helpers */
-extern int
-pnfs_osd_xdr_encode_layoutupdate(struct xdr_stream *xdr,
-				 struct pnfs_osd_layoutupdate *lou);
-
-/* osd_ioerror encoding (layout_return) */
-extern __be32 *pnfs_osd_xdr_ioerr_reserve_space(struct xdr_stream *xdr);
-extern void pnfs_osd_xdr_encode_ioerr(__be32 *p, struct pnfs_osd_ioerr *ioerr);
-
-#endif /* __PNFS_OSD_XDR_H__ */
-- 
2.31.1

