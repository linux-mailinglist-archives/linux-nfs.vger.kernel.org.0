Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67354A3866
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jan 2022 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiA3TGT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jan 2022 14:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbiA3TGT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jan 2022 14:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643569579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9GC9lxoMRFJ2n/Lsv4BPZonyKxRoqpi4kXGiiewDxQ=;
        b=C3hEwBvkqpomx51HG8e/IiBilAVWwnzY87qR+u6t7UBT1HP6jpBkYjlUpTpabLfAjCB6qo
        jGerhZMKCo4cqomSFAx8YR90xIuhVzWBMi0VBm5gmABSSU651xPZ2NkmokkW41d6Uo5Grv
        94ZWwLDrg79UpCEsWlbMJR725WJiCbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-MgZCw5iBNumjtoCCgCY6Qg-1; Sun, 30 Jan 2022 14:06:17 -0500
X-MC-Unique: MgZCw5iBNumjtoCCgCY6Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CE12814243;
        Sun, 30 Jan 2022 19:06:16 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E9F60854;
        Sun, 30 Jan 2022 19:06:15 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Bill Baker <webbaker@gmail.com>,
        Calum Mackay <calum.mackay@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 5/5] configs: Add an nfsall.conf config file
Date:   Sun, 30 Jan 2022 14:06:11 -0500
Message-Id: <20220130190611.12292-6-steved@redhat.com>
In-Reply-To: <20220130190611.12292-1-steved@redhat.com>
References: <20220130190611.12292-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsall.conf file list all the possible
nfs, nfsv4 and sunrpc tracepoints, commented
out. The file will be installed into the /etc/fdr.d,
allowing to easily set any and all NFS tracepoints.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 buildrpm/1.3/fdr.spec |   6 +
 configs/nfsall.conf   | 319 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 325 insertions(+)
 create mode 100644 configs/nfsall.conf

diff --git a/buildrpm/1.3/fdr.spec b/buildrpm/1.3/fdr.spec
index 226db33..b69e306 100644
--- a/buildrpm/1.3/fdr.spec
+++ b/buildrpm/1.3/fdr.spec
@@ -4,6 +4,7 @@ URL:		https://github.com/oracle/fdr.git
 Version:	1.3
 Release:	3%{?dist}
 License:	UPL
+
 Source0:	http://people.redhat.com/steved/fdr/%{name}-%{version}.tar.xz
 
 BuildRequires:	gcc
@@ -36,6 +37,9 @@ install -m 644 samples/nfs.logrotate %{buildroot}/%{_sysconfdir}/logrotate.d/nfs
 mkdir -p %{buildroot}/%{_unitdir}
 install -m 644 %{name}d.service %{buildroot}/%{_unitdir}/%{name}d.service
 
+mkdir -p %{buildroot}%{_sysconfdir}/%{name}.d
+install -m 644 configs/nfsall.conf %{buildroot}%{_sysconfdir}/%{name}.d/
+
 mkdir -p %{buildroot}/%{_mandir}/man8
 install -m 644 fdrd.man %{buildroot}/%{_mandir}/man8/fdrd.8
 
@@ -53,6 +57,8 @@ install -m 644 fdrd.man %{buildroot}/%{_mandir}/man8/fdrd.8
 %{_unitdir}/fdrd.service
 %{_datadir}/fdr/samples/nfs
 %{_sysconfdir}/logrotate.d/nfs
+%{_sysconfdir}/%{name}.d
+%{_sysconfdir}/%{name}.d/nfsall.conf
 %{_mandir}/man8/*
 %doc README.md
 %license LICENSE
diff --git a/configs/nfsall.conf b/configs/nfsall.conf
new file mode 100644
index 0000000..b251ac2
--- /dev/null
+++ b/configs/nfsall.conf
@@ -0,0 +1,319 @@
+#
+# This config file has all of the tracepoints
+# for the nfs, nfsv4 and sunrpc modules.
+#
+# To enable them simply uncomment the line and
+# restart fdrd:
+#     systemctl start fdrd
+#
+
+instance nfsall
+# nfs4 will drag in sunrpc & nfs as deps
+modprobe nfsv4
+
+#enable nfs/nfs_access_enter
+#enable nfs/nfs_access_exit
+#enable nfs/nfs_aop_readahead
+#enable nfs/nfs_aop_readahead_done
+#enable nfs/nfs_aop_readpage
+#enable nfs/nfs_aop_readpage_done
+#enable nfs/nfs_atomic_open_enter
+#enable nfs/nfs_atomic_open_exit
+#enable nfs/nfs_commit_done
+#enable nfs/nfs_commit_error
+#enable nfs/nfs_comp_error
+#enable nfs/nfs_create_enter
+#enable nfs/nfs_create_exit
+#enable nfs/nfs_fh_to_dentry
+#enable nfs/nfs_fsync_enter
+#enable nfs/nfs_fsync_exit
+#enable nfs/nfs_getattr_enter
+#enable nfs/nfs_getattr_exit
+#enable nfs/nfs_initiate_commit
+#enable nfs/nfs_initiate_read
+#enable nfs/nfs_initiate_write
+#enable nfs/nfs_invalidate_mapping_enter
+#enable nfs/nfs_invalidate_mapping_exit
+#enable nfs/nfs_link_enter
+#enable nfs/nfs_link_exit
+#enable nfs/nfs_lookup_enter
+#enable nfs/nfs_lookup_exit
+#enable nfs/nfs_lookup_revalidate_enter
+#enable nfs/nfs_lookup_revalidate_exit
+#enable nfs/nfs_mkdir_enter
+#enable nfs/nfs_mkdir_exit
+#enable nfs/nfs_mknod_enter
+#enable nfs/nfs_mknod_exit
+#enable nfs/nfs_pgio_error
+#enable nfs/nfs_readpage_done
+#enable nfs/nfs_readpage_short
+#enable nfs/nfs_refresh_inode_enter
+#enable nfs/nfs_refresh_inode_exit
+#enable nfs/nfs_remove_enter
+#enable nfs/nfs_remove_exit
+#enable nfs/nfs_rename_enter
+#enable nfs/nfs_rename_exit
+#enable nfs/nfs_revalidate_inode_enter
+#enable nfs/nfs_revalidate_inode_exit
+#enable nfs/nfs_rmdir_enter
+#enable nfs/nfs_rmdir_exit
+#enable nfs/nfs_setattr_enter
+#enable nfs/nfs_setattr_exit
+#enable nfs/nfs_set_cache_invalid
+#enable nfs/nfs_set_inode_stale
+#enable nfs/nfs_sillyrename_rename
+#enable nfs/nfs_sillyrename_unlink
+#enable nfs/nfs_size_grow
+#enable nfs/nfs_size_truncate
+#enable nfs/nfs_size_update
+#enable nfs/nfs_size_wcc
+#enable nfs/nfs_symlink_enter
+#enable nfs/nfs_symlink_exit
+#enable nfs/nfs_unlink_enter
+#enable nfs/nfs_unlink_exit
+#enable nfs/nfs_writeback_done
+#enable nfs/nfs_writeback_inode_enter
+#enable nfs/nfs_writeback_inode_exit
+#enable nfs/nfs_writeback_page_enter
+#enable nfs/nfs_writeback_page_exit
+#enable nfs/nfs_write_error
+#enable nfs/nfs_xdr_bad_filehandle
+#enable nfs/nfs_xdr_status
+#
+#
+#enable nfs4/ff_layout_commit_error
+#enable nfs4/ff_layout_read_error
+#enable nfs4/ff_layout_write_error
+#enable nfs4/nfs4_access
+#enable nfs4/nfs4_bind_conn_to_session
+#enable nfs4/nfs4_cached_open
+#enable nfs4/nfs4_cb_getattr
+#enable nfs4/nfs4_cb_layoutrecall_file
+#enable nfs4/nfs4_cb_offload
+#enable nfs4/nfs4_cb_recall
+#enable nfs4/nfs4_cb_seqid_err
+#enable nfs4/nfs4_cb_sequence
+#enable nfs4/nfs4_clone
+#enable nfs4/nfs4_close
+#enable nfs4/nfs4_close_stateid_update_wait
+#enable nfs4/nfs4_commit
+#enable nfs4/nfs4_copy
+#enable nfs4/nfs4_copy_notify
+#enable nfs4/nfs4_create_session
+#enable nfs4/nfs4_deallocate
+#enable nfs4/nfs4_delegreturn
+#enable nfs4/nfs4_delegreturn_exit
+#enable nfs4/nfs4_destroy_clientid
+#enable nfs4/nfs4_destroy_session
+#enable nfs4/nfs4_deviceid_free
+#enable nfs4/nfs4_exchange_id
+#enable nfs4/nfs4_fallocate
+#enable nfs4/nfs4_find_deviceid
+#enable nfs4/nfs4_fsinfo
+#enable nfs4/nfs4_get_acl
+#enable nfs4/nfs4_getattr
+#enable nfs4/nfs4_getdeviceinfo
+#enable nfs4/nfs4_get_fs_locations
+#enable nfs4/nfs4_get_lock
+#enable nfs4/nfs4_get_security_label
+#enable nfs4/nfs4_layoutcommit
+#enable nfs4/nfs4_layouterror
+#enable nfs4/nfs4_layoutget
+#enable nfs4/nfs4_layoutreturn
+#enable nfs4/nfs4_layoutreturn_on_close
+#enable nfs4/nfs4_layoutstats
+#enable nfs4/nfs4_llseek
+#enable nfs4/nfs4_lookup
+#enable nfs4/nfs4_lookupp
+#enable nfs4/nfs4_lookup_root
+#enable nfs4/nfs4_map_gid_to_group
+#enable nfs4/nfs4_map_group_to_gid
+#enable nfs4/nfs4_map_name_to_uid
+#enable nfs4/nfs4_map_uid_to_name
+#enable nfs4/nfs4_mkdir
+#enable nfs4/nfs4_mknod
+#enable nfs4/nfs4_offload_cancel
+#enable nfs4/nfs4_open_expired
+#enable nfs4/nfs4_open_file
+#enable nfs4/nfs4_open_reclaim
+#enable nfs4/nfs4_open_stateid_update
+#enable nfs4/nfs4_open_stateid_update_wait
+#enable nfs4/nfs4_pnfs_commit_ds
+#enable nfs4/nfs4_pnfs_read
+#enable nfs4/nfs4_pnfs_write
+#enable nfs4/nfs4_read
+#enable nfs4/nfs4_readdir
+#enable nfs4/nfs4_readlink
+#enable nfs4/nfs4_reclaim_complete
+#enable nfs4/nfs4_reclaim_delegation
+#enable nfs4/nfs4_remove
+#enable nfs4/nfs4_rename
+#enable nfs4/nfs4_renew
+#enable nfs4/nfs4_renew_async
+#enable nfs4/nfs4_secinfo
+#enable nfs4/nfs4_sequence
+#enable nfs4/nfs4_sequence_done
+#enable nfs4/nfs4_set_acl
+#enable nfs4/nfs4_setattr
+#enable nfs4/nfs4_setclientid
+#enable nfs4/nfs4_setclientid_confirm
+#enable nfs4/nfs4_set_delegation
+#enable nfs4/nfs4_set_lock
+#enable nfs4/nfs4_set_security_label
+#enable nfs4/nfs4_setup_sequence
+#enable nfs4/nfs4_state_lock_reclaim
+#enable nfs4/nfs4_state_mgr
+#enable nfs4/nfs4_state_mgr_failed
+#enable nfs4/nfs4_symlink
+#enable nfs4/nfs4_test_delegation_stateid
+#enable nfs4/nfs4_test_lock_stateid
+#enable nfs4/nfs4_test_open_stateid
+#enable nfs4/nfs4_unlock
+#enable nfs4/nfs4_write
+#enable nfs4/nfs4_xdr_bad_filehandle
+#enable nfs4/nfs4_xdr_bad_operation
+#enable nfs4/nfs4_xdr_status
+#enable nfs4/nfs_cb_badprinc
+#enable nfs4/nfs_cb_no_clp
+#enable nfs4/pnfs_mds_fallback_pg_get_mirror_count
+#enable nfs4/pnfs_mds_fallback_pg_init_read
+#enable nfs4/pnfs_mds_fallback_pg_init_write
+#enable nfs4/pnfs_mds_fallback_read_done
+#enable nfs4/pnfs_mds_fallback_read_pagelist
+#enable nfs4/pnfs_mds_fallback_write_done
+#enable nfs4/pnfs_mds_fallback_write_pagelist
+#enable nfs4/pnfs_update_layout
+#
+#
+#enable sunrpc/cache_entry_expired
+#enable sunrpc/cache_entry_make_negative
+#enable sunrpc/cache_entry_no_listener
+#enable sunrpc/cache_entry_upcall
+#enable sunrpc/cache_entry_update
+#enable sunrpc/pmap_register
+#enable sunrpc/rpc__auth_tooweak
+#enable sunrpc/rpc_bad_callhdr
+#enable sunrpc/rpc__bad_creds
+#enable sunrpc/rpc_bad_verifier
+#enable sunrpc/rpcb_bind_version_err
+#enable sunrpc/rpcb_getport
+#enable sunrpc/rpcb_prog_unavail_err
+#enable sunrpc/rpcb_register
+#enable sunrpc/rpcb_setport
+#enable sunrpc/rpcb_timeout_err
+#enable sunrpc/rpc_buf_alloc
+#enable sunrpc/rpcb_unreachable_err
+#enable sunrpc/rpcb_unrecognized_err
+#enable sunrpc/rpcb_unregister
+#enable sunrpc/rpc_call_rpcerror
+#enable sunrpc/rpc_call_status
+#enable sunrpc/rpc_clnt_clone_err
+#enable sunrpc/rpc_clnt_free
+#enable sunrpc/rpc_clnt_killall
+#enable sunrpc/rpc_clnt_new
+#enable sunrpc/rpc_clnt_new_err
+#enable sunrpc/rpc_clnt_release
+#enable sunrpc/rpc_clnt_replace_xprt
+#enable sunrpc/rpc_clnt_replace_xprt_err
+#enable sunrpc/rpc_clnt_shutdown
+#enable sunrpc/rpc_connect_status
+#enable sunrpc/rpc__garbage_args
+#enable sunrpc/rpc__mismatch
+#enable sunrpc/rpc__proc_unavail
+#enable sunrpc/rpc__prog_mismatch
+#enable sunrpc/rpc__prog_unavail
+#enable sunrpc/rpc_refresh_status
+#enable sunrpc/rpc_request
+#enable sunrpc/rpc_retry_refresh_status
+#enable sunrpc/rpc_socket_close
+#enable sunrpc/rpc_socket_connect
+#enable sunrpc/rpc_socket_error
+#enable sunrpc/rpc_socket_nospace
+#enable sunrpc/rpc_socket_reset_connection
+#enable sunrpc/rpc_socket_shutdown
+#enable sunrpc/rpc_socket_state_change
+#enable sunrpc/rpc__stale_creds
+#enable sunrpc/rpc_stats_latency
+#enable sunrpc/rpc_task_begin
+#enable sunrpc/rpc_task_call_done
+#enable sunrpc/rpc_task_complete
+#enable sunrpc/rpc_task_end
+#enable sunrpc/rpc_task_run_action
+#enable sunrpc/rpc_task_signalled
+#enable sunrpc/rpc_task_sleep
+#enable sunrpc/rpc_task_sync_sleep
+#enable sunrpc/rpc_task_sync_wake
+#enable sunrpc/rpc_task_timeout
+#enable sunrpc/rpc_task_wakeup
+#enable sunrpc/rpc_timeout_status
+#enable sunrpc/rpc__unparsable
+#enable sunrpc/rpc_xdr_alignment
+#enable sunrpc/rpc_xdr_overflow
+#enable sunrpc/rpc_xdr_recvfrom
+#enable sunrpc/rpc_xdr_reply_pages
+#enable sunrpc/rpc_xdr_sendto
+#enable sunrpc/svc_alloc_arg_err
+#enable sunrpc/svc_authenticate
+#enable sunrpc/svc_defer
+#enable sunrpc/svc_defer_drop
+#enable sunrpc/svc_defer_queue
+#enable sunrpc/svc_defer_recv
+#enable sunrpc/svc_drop
+#enable sunrpc/svc_handle_xprt
+#enable sunrpc/svc_noregister
+#enable sunrpc/svc_process
+#enable sunrpc/svc_register
+#enable sunrpc/svc_send
+#enable sunrpc/svcsock_accept_err
+#enable sunrpc/svcsock_data_ready
+#enable sunrpc/svcsock_getpeername_err
+#enable sunrpc/svcsock_marker
+#enable sunrpc/svcsock_new_socket
+#enable sunrpc/svcsock_tcp_recv
+#enable sunrpc/svcsock_tcp_recv_eagain
+#enable sunrpc/svcsock_tcp_recv_err
+#enable sunrpc/svcsock_tcp_recv_short
+#enable sunrpc/svcsock_tcp_send
+#enable sunrpc/svcsock_tcp_state
+#enable sunrpc/svcsock_udp_recv
+#enable sunrpc/svcsock_udp_recv_err
+#enable sunrpc/svcsock_udp_send
+#enable sunrpc/svcsock_write_space
+#enable sunrpc/svc_stats_latency
+#enable sunrpc/svc_unregister
+#enable sunrpc/svc_wake_up
+#enable sunrpc/svc_xdr_recvfrom
+#enable sunrpc/svc_xdr_sendto
+#enable sunrpc/svc_xprt_accept
+#enable sunrpc/svc_xprt_close
+#enable sunrpc/svc_xprt_create_err
+#enable sunrpc/svc_xprt_dequeue
+#enable sunrpc/svc_xprt_detach
+#enable sunrpc/svc_xprt_do_enqueue
+#enable sunrpc/svc_xprt_free
+#enable sunrpc/svc_xprt_no_write_space
+#enable sunrpc/svc_xprt_received
+#enable sunrpc/xprt_connect
+#enable sunrpc/xprt_create
+#enable sunrpc/xprt_destroy
+#enable sunrpc/xprt_disconnect_auto
+#enable sunrpc/xprt_disconnect_cleanup
+#enable sunrpc/xprt_disconnect_done
+#enable sunrpc/xprt_disconnect_force
+#enable sunrpc/xprt_get_cong
+#enable sunrpc/xprt_lookup_rqst
+#enable sunrpc/xprt_ping
+#enable sunrpc/xprt_put_cong
+#enable sunrpc/xprt_release_cong
+#enable sunrpc/xprt_release_xprt
+#enable sunrpc/xprt_reserve
+#enable sunrpc/xprt_reserve_cong
+#enable sunrpc/xprt_reserve_xprt
+#enable sunrpc/xprt_retransmit
+#enable sunrpc/xprt_timer
+#enable sunrpc/xprt_transmit
+#enable sunrpc/xs_stream_read_data
+#enable sunrpc/xs_stream_read_request
+
+# save output to this file up to [maxsiz]
+saveto /var/log/nfs.log 500k
-- 
2.34.1

