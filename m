Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78379AFB9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjIKV6i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbjIKMuO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 08:50:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19ACEB
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 05:50:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39166C433C8;
        Mon, 11 Sep 2023 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694436609;
        bh=tHzf9IpTRRObT2Wt3tnU7xQFrfxfs3mf7RJ8SD6UTgk=;
        h=From:To:Cc:Subject:Date:From;
        b=giXe9f9PkYJf6xsj7SqiplLBd9eSD1v1yjrk9YCiV93a/XC0+Vvo+gfcvRTiaoU48
         AzoCqKhcLJ+1CK7wKweXDpCjKyP4DAOmMyZmasWKdmRKwOOgcDf8ohsGGMuyjT0n45
         odqgjihH6iO02MrjqyhfbRm5ybcCZ5L4PqkFCMGvrprboc6Wf1z7kY8VoWKexo5/E+
         aqJxjF4fCGfOG2f9b4NlAyK+VA4H1N3j4+TygbmA0/O3sqLSggw3rOGqwzpnQFROnT
         AD8R9qw+Aum1gvwe1ym6vzvVH3hqhY64Rny51xFwJleurhhYIqjNe9Qq/UIrTbLDew
         4YFIFQKy+s5xA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: [PATCH v8 0/3] add rpc_status netlink support for NFSD
Date:   Mon, 11 Sep 2023 14:49:43 +0200
Message-ID: <cover.1694436263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status netlink support for NFSD in order to dump pending
RPC requests debugging information from userspace.
The new code can be tested with the user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-rpc-netlink-monitor/tree/main

Changes since v7:
- introduce nfsd_server.yaml for netlink messages

Changes since v6:
- report info to user-space through netlink and get rid of the related
  entry in the procfs

Changes since v5:
- add missing delimiters for nfs4 compound ops
- add a header line for rpc_status handler
- do not dump rq_prog
- do not dump rq_flags in hex

Changes since v4:
- rely on acquire/release APIs and get rid of atomic operation
- fix kdoc for nfsd_rpc_status_open
- get rid of ',' as field delimiter in nfsd_rpc_status hanlder
- move nfsd_rpc_status before nfsd_v4 enum entries
- fix compilantion error if nfsdv4 is not enabled

Changes since v3:
- introduce rq_status_counter in order to detect if the RPC request is
  pending and RPC info are stable
- rely on __svc_print_addr to dump IP info

Changes since v2:
- minor changes in nfsd_rpc_status_show output

Changes since v1:
- rework nfsd_rpc_status_show output

Changes since RFCv1:
- riduce time holding nfsd_mutex bumping svc_serv refcoung in
  nfsd_rpc_status_open()
- dump rqstp->rq_stime
- add missing kdoc for nfsd_rpc_status_open()

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D3D3D366

Lorenzo Bianconi (3):
  Documentation: netlink: add a YAML spec for nfsd_server
  NFSD: introduce netlink rpc_status stubs
  NFSD: add rpc_status netlink support

 Documentation/netlink/specs/nfsd_server.yaml |  97 +++++++++
 fs/nfsd/Makefile                             |   3 +-
 fs/nfsd/nfs_netlink_gen.c                    |  32 +++
 fs/nfsd/nfs_netlink_gen.h                    |  22 ++
 fs/nfsd/nfsctl.c                             | 204 +++++++++++++++++++
 fs/nfsd/nfsd.h                               |  16 ++
 fs/nfsd/nfssvc.c                             |  15 ++
 fs/nfsd/state.h                              |   2 -
 include/linux/sunrpc/svc.h                   |   1 +
 include/uapi/linux/nfsd_server.h             |  49 +++++
 10 files changed, 438 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
 create mode 100644 fs/nfsd/nfs_netlink_gen.c
 create mode 100644 fs/nfsd/nfs_netlink_gen.h
 create mode 100644 include/uapi/linux/nfsd_server.h

-- 
2.41.0

