Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87F369409
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhDWNum (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 09:50:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDWNul (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Apr 2021 09:50:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27BE3AF49;
        Fri, 23 Apr 2021 13:50:04 +0000 (UTC)
Date:   Fri, 23 Apr 2021 15:50:02 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Message-ID: <YILQip3nAxhpXP9+@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422202334.GB25415@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> > LTP NFS tests (which use netns) fails on tmpfs since d4066486:

> > mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> > mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory

> We should figure out the reason for the failure.  A network trace might
> help.

> --b.

I'm sorry previous log I sent was log from some different debugging.
Sending actual logs for version 4 (removed duplicate events).

Logs for 4.1 and 4.2 are slightly different, but "cannot create RPC client" is
the same; I can also send mount.nfs strace output if useful.

Some more info (tested on both 2f669b6f - current master and d4066486):
version 3 is not affected. Affected versions: 4, 4.1, 4.2.

rpcdebug -m nfs -s all; rpcdebug -m nfsd -s all; rpcdebug -m rpc -s all

[14800.072718] nfsd_inet6addr_event: removed fd00:0001:0001:0001:0000:0000:0000:0002
[14800.074310] nfsd_inet6addr_event: removed fe80:0000:0000:0000:1463:9fff:fea6:01b1
[14800.079600] nfsd_inetaddr_event: removed 10.0.0.2
[14800.083410] IPv6: ADDRCONF(NETDEV_CHANGE): ltp_ns_veth2: link becomes ready
[14800.280525] NFS:   parsing nfs mount option 'source'
[14800.282709] NFS:   parsing nfs mount option 'proto'
[14800.284300] NFS:   parsing nfs mount option 'vers'
[14800.286041] NFS:   parsing nfs mount option 'addr'
[14800.287636] NFS:   parsing nfs mount option 'clientaddr'
[14800.289344] NFS: MNTPATH: '/tmp/ltp.nfs01.nfs-4/LTP_nfs01.ny7RbNMo0D/4/tcp'
[14800.290754] --> nfs4_try_get_tree()
[14800.292518] NFS: get client cookie (0x00000000375cff7e/0x00000000c0f026bb)
[14800.293862] RPC:       set up xprt to 10.0.0.2 (port 2049) via tcp
[14800.295100] RPC:       Couldn't create auth handle (flavor 390004)
[14800.296295] nfs_create_rpc_client: cannot create RPC client. Error = -22
[14800.298345] RPC:       set up xprt to 10.0.0.2 (port 2049) via tcp
[14800.298632] RPC:        destroy backchannel transport
[14800.299710] RPC:       xs_connect scheduled xprt 000000004980c4c0
[14800.300781] RPC:        backchannel list empty= true
[14800.300782] RPC:       xs_destroy xprt 000000001716165f
[14800.301466] RPC:       xs_close xprt 000000001716165f
[14800.302416] RPC:       xs_bind 0.0.0.0:921: ok (0)
[14800.306603] RPC:       worker connecting xprt 000000004980c4c0 via tcp to 10.0.0.2 (port 2049)
[14800.308268] RPC:       xs_tcp_state_change client 000000004980c4c0...
[14800.309531] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[14800.310827] RPC:       000000004980c4c0 connect status 115 connected 1 sock state 1
[14800.310871] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.313880] RPC:       xs_tcp_send_request(40) = 0
[14800.314812] svc: svc_authenticate (0)
[14800.316079] svc: calling dispatcher
[14800.316669] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.317884] RPC:       xs_data_ready...
[14800.319547] --> nfs4_realloc_slot_table: max_reqs=1024, tbl->max_slots 0
[14800.322475] nfs4_realloc_slot_table: tbl=000000002fac0907 slots=000000005bb343d4 max_slots=1024
[14800.324088] <-- nfs4_realloc_slot_table: return 0
[14800.325937] svc: initialising pool 0 for NFSv4 callback
[14800.327108] nfs_callback_create_svc: service created
[14800.328222] NFS: create per-net callback data; net=f0000304
[14800.330210] NFS: Callback listener port = 35999 (af 2, net f0000304)
[14800.332216] NFS: Callback listener port = 33759 (af 10, net f0000304)
[14800.334658] nfs_callback_up: service started
[14800.335704] svc: svc_destroy(NFSv4 callback, 2)
[14800.336789] NFS: nfs4_discover_server_trunking: testing '10.0.0.2'
[14800.338131] NFS call  setclientid auth=UNIX, 'Linux NFSv4.0 opensuse-20201019/10.0.0.2'
[14800.339738] RPC:       xs_tcp_send_request(184) = 0
[14800.339776] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.342797] svc: svc_authenticate (1)
[14800.343828] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.345197] RPC:       Want update, refage=120, age=0
[14800.347277] RPC:       Want update, refage=120, age=0
[14800.348484] svc: calling dispatcher
[14800.350321] RPC:       xs_data_ready...
[14800.352245] NFS reply setclientid: 0
[14800.353334] NFS call  setclientid_confirm auth=UNIX, (client ID 168c82609a2db6cf)
[14800.354955] RPC:       xs_tcp_send_request(112) = 0
[14800.354990] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.358191] svc: svc_authenticate (1)
[14800.358553] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.360759] svc: calling dispatcher
[14800.362584] NFSD: move_to_confirm nfs4_client 00000000d2d16ac0
[14800.364089] RPC:       set up xprt to 10.0.0.1 (port 35999) via tcp
[14800.365557] RPC:       xs_connect scheduled xprt 000000001716165f
[14800.365863] RPC:       xs_data_ready...
[14800.366918] RPC:       xs_bind 10.0.0.2:1017: ok (0)
[14800.368053] NFS reply setclientid_confirm: 0
[14800.369181] RPC:       worker connecting xprt 000000001716165f via tcp to 10.0.0.1 (port 35999)
[14800.370252] nfs4_schedule_state_renewal: requeueing work. Lease period = 5
[14800.372248] RPC:       xs_tcp_state_change client 000000001716165f...
[14800.375198] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[14800.376575] RPC:       000000001716165f connect status 115 connected 1 sock state 1
[14800.377017] svc: server 0000000037f454bf, pool 0, transport 0000000036c0bdf0, inuse=2
[14800.378141] RPC:       xs_tcp_send_request(80) = 0
[14800.379650] svc: svc_authenticate (1)
[14800.382291] RPC:       xs_data_ready...
[14800.383450] NFS: nfs4_discover_server_trunking: status = 0
[14800.384866] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.386485] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.388769] svc: server 0000000037f454bf, pool 0, transport 0000000036c0bdf0, inuse=2
[14800.390337] RPC:       xs_tcp_send_request(120) = 0
[14800.391734] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.394532] svc: svc_authenticate (1)
[14800.395538] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.398189] svc: calling dispatcher
[14800.399205] RPC:       Want update, refage=120, age=0
[14800.401214] nfsd: fh_compose(exp 00:2b/256 1/snapshot, ino=256)
[14800.402634] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.404315] RPC:       xs_data_ready...
[14800.406649] decode_attr_type: type=040000
[14800.407898] decode_attr_change: change attribute=6954294660659412992
[14800.409259] decode_attr_size: file size=154
[14800.410365] decode_attr_fsid: fsid=(0x0/0x0)
[14800.411402] decode_attr_fileid: fileid=256
[14800.412435] decode_attr_fs_locations: fs_locations done, error = 0
[14800.413820] decode_attr_mode: file mode=0755
[14800.414840] decode_attr_nlink: nlink=1
[14800.415783] decode_attr_owner: uid=0
[14800.416707] decode_attr_group: gid=0
[14800.417733] decode_attr_rdev: rdev=(0x0:0x0)
[14800.418845] decode_attr_space_used: space used=0
[14800.419881] decode_attr_time_access: atime=1619115491
[14800.421083] decode_attr_time_metadata: ctime=1618569204
[14800.422241] decode_attr_time_modify: mtime=1618569204
[14800.423320] decode_attr_mounted_on_fileid: fileid=1
[14800.424513] decode_getfattr_attrs: xdr returned 0
[14800.425614] decode_getfattr_generic: xdr returned 0
[14800.426669] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.426713] NFS call  setclientid auth=UNIX, 'Linux NFSv4.0 opensuse-20201019/10.0.0.2'
[14800.429835] RPC:       xs_tcp_send_request(184) = 0
[14800.431412] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.434120] svc: svc_authenticate (1)
[14800.434166] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.436380] svc: calling dispatcher
[14800.438361] RPC:       xs_data_ready...
[14800.439350] NFS reply setclientid: 0
[14800.440253] NFS call  setclientid_confirm auth=UNIX, (client ID 168c82609a2db6cf)
[14800.442050] RPC:       xs_tcp_send_request(112) = 0
[14800.442051] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.445339] svc: svc_authenticate (1)
[14800.445795] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.446427] svc: calling dispatcher
[14800.449387] RPC:       set up xprt to 10.0.0.1 (port 35999) via tcp
[14800.451055] RPC:       xs_connect scheduled xprt 00000000b9cef903
[14800.452346] RPC:       xs_bind 10.0.0.2:949: ok (0)
[14800.453103] RPC:        destroy backchannel transport
[14800.453725] RPC:       worker connecting xprt 00000000b9cef903 via tcp to 10.0.0.1 (port 35999)
[14800.454807] RPC:        backchannel list empty= true
[14800.456406] RPC:       xs_tcp_state_change client 00000000b9cef903...
[14800.457444] RPC:       xs_destroy xprt 000000001716165f
[14800.458832] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[14800.461346] RPC:       00000000b9cef903 connect status 115 connected 1 sock state 1
[14800.461982] RPC:       xs_data_ready...
[14800.463235] RPC:       xs_tcp_send_request(80) = 0
[14800.464163] RPC:       xs_close xprt 000000001716165f
[14800.465413] svc: server 0000000037f454bf, pool 0, transport 00000000587e5d0e, inuse=2
[14800.467446] RPC:       xs_tcp_state_change client 000000001716165f...
[14800.468005] svc: svc_authenticate (1)
[14800.469354] RPC:       state 4 conn 1 dead 0 zapped 1 sk_shutdown 3
[14800.470337] NFS reply setclientid_confirm: 0
[14800.473062] --> nfs4_get_lease_time_prepare
[14800.474272] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.475926] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.477197] <-- nfs4_get_lease_time_prepare
[14800.479389] RPC:       xs_data_ready...
[14800.481004] svc: server 0000000037f454bf, pool 0, transport 00000000587e5d0e, inuse=2
[14800.483759] RPC:       xs_tcp_send_request(108) = 0
[14800.485086] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.486634] svc: svc_authenticate (1)
[14800.486678] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.487662] svc: calling dispatcher
[14800.490136] nfsd: fh_compose(exp 00:2b/256 1/snapshot, ino=256)
[14800.491396] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.494042] RPC:       xs_data_ready...
[14800.495690] decode_attr_lease_time: lease time=90
[14800.496924] decode_attr_maxfilesize: maxfilesize=0
[14800.498144] decode_attr_maxread: maxread=1024
[14800.499160] decode_attr_maxwrite: maxwrite=1024
[14800.500188] decode_attr_time_delta: time_delta=0 0
[14800.501373] decode_attr_pnfstype: bitmap is 0
[14800.502884] decode_attr_layout_blksize: bitmap is 0
[14800.503986] decode_attr_clone_blksize: bitmap is 0
[14800.505105] decode_attr_xattrsupport: XATTR support=false
[14800.506377] decode_fsinfo: xdr returned 0!
[14800.507376] --> nfs4_get_lease_time_done
[14800.508392] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.509692] <-- nfs4_get_lease_time_done
[14800.510785] nfs4_schedule_state_renewal: requeueing work. Lease period = 60
[14800.512069] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.513788] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.515322] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=1024
[14800.515417] RPC:       xs_tcp_send_request(124) = 0
[14800.516681] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[14800.516682] nfs4_free_slot: slotid 1 highest_used_slotid 0
[14800.520157] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.522542] svc: svc_authenticate (1)
[14800.522552] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.525723] svc: calling dispatcher
[14800.526792] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.528612] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.531547] RPC:       xs_data_ready...
[14800.532940] decode_attr_supported: bitmask=fdffbfff:00f9be3e:00000000
[14800.534531] decode_attr_fh_expire_type: expire type=0x0
[14800.535725] decode_attr_link_support: link support=true
[14800.536903] decode_attr_symlink_support: symlink support=true
[14800.538190] decode_attr_aclsupport: ACLs supported=3
[14800.539279] decode_attr_exclcreat_supported: bitmask=00000000:00000000:00000000
[14800.540771] decode_server_caps: xdr returned 0!
[14800.541862] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.544291] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.545870] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.547897] RPC:       xs_tcp_send_request(128) = 0
[14800.547942] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.550686] svc: svc_authenticate (1)
[14800.550696] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.553660] svc: calling dispatcher
[14800.554652] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.556145] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.557709] RPC:       xs_data_ready...
[14800.558760] decode_attr_lease_time: lease time=90
[14800.559953] decode_attr_maxfilesize: maxfilesize=9223372036854775807
[14800.561356] decode_attr_maxread: maxread=262144
[14800.562624] decode_attr_maxwrite: maxwrite=262144
[14800.563691] decode_attr_time_delta: time_delta=0 4000000
[14800.564842] decode_attr_pnfstype: bitmap is 0
[14800.565949] decode_attr_layout_blksize: bitmap is 0
[14800.566991] decode_attr_clone_blksize: bitmap is 0
[14800.568051] decode_attr_xattrsupport: XATTR support=false
[14800.569189] decode_fsinfo: xdr returned 0!
[14800.570291] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.571563] Server FSID: 0:0
[14800.572362] Pseudo-fs root FH at 0000000027e10228 is 8 bytes, crc: 0x62d40c52:
[14800.574375]  01000100 00000000
[14800.575881] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.577423] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.579460] RPC:       xs_tcp_send_request(124) = 0
[14800.579468] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.582290] svc: svc_authenticate (1)
[14800.582299] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.584810] svc: calling dispatcher
[14800.586149] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.587905] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.590556] RPC:       xs_data_ready...
[14800.591722] decode_attr_supported: bitmask=fdffbfff:00f9be3e:00000000
[14800.593175] decode_attr_fh_expire_type: expire type=0x0
[14800.594431] decode_attr_link_support: link support=true
[14800.595599] decode_attr_symlink_support: symlink support=true
[14800.596807] decode_attr_aclsupport: ACLs supported=3
[14800.598052] decode_attr_exclcreat_supported: bitmask=00000000:00000000:00000000
[14800.599408] decode_server_caps: xdr returned 0!
[14800.600460] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.602427] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.604231] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.606368] RPC:       xs_tcp_send_request(128) = 0
[14800.606400] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.609425] svc: svc_authenticate (1)
[14800.609830] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.611857] svc: calling dispatcher
[14800.613382] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.615566] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.617774] RPC:       xs_data_ready...
[14800.618878] decode_attr_lease_time: lease time=90
[14800.620114] decode_attr_maxfilesize: maxfilesize=9223372036854775807
[14800.621481] decode_attr_maxread: maxread=262144
[14800.622606] decode_attr_maxwrite: maxwrite=262144
[14800.623718] decode_attr_time_delta: time_delta=0 4000000
[14800.624904] decode_attr_pnfstype: bitmap is 0
[14800.626040] decode_attr_layout_blksize: bitmap is 0
[14800.627086] decode_attr_clone_blksize: bitmap is 0
[14800.628147] decode_attr_xattrsupport: XATTR support=false
[14800.629278] decode_fsinfo: xdr returned 0!
[14800.630307] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.631562] set_pnfs_layoutdriver: Using NFSv4 I/O
[14800.633911] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.635477] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.637411] RPC:       xs_tcp_send_request(124) = 0
[14800.637457] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.640086] svc: svc_authenticate (1)
[14800.641307] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.642092] svc: calling dispatcher
[14800.643897] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.646029] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.647631] RPC:       xs_data_ready...
[14800.649827] decode_attr_maxlink: maxlink=255
[14800.650923] decode_attr_maxname: maxname=255
[14800.652117] decode_pathconf: xdr returned 0!
[14800.653154] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.654451] NFS:   parsing nfs mount option 'source'
[14800.655504] NFS: MNTPATH: '/'
[14800.658220] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.659739] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.661818] RPC:       xs_tcp_send_request(124) = 0
[14800.661826] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.665600] svc: svc_authenticate (1)
[14800.665618] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.667892] svc: calling dispatcher
[14800.669153] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.672199] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.674996] RPC:       xs_data_ready...
[14800.676133] decode_attr_supported: bitmask=fdffbfff:00f9be3e:00000000
[14800.677669] decode_attr_fh_expire_type: expire type=0x0
[14800.678859] decode_attr_link_support: link support=true
[14800.679990] decode_attr_symlink_support: symlink support=true
[14800.681204] decode_attr_aclsupport: ACLs supported=3
[14800.682355] decode_attr_exclcreat_supported: bitmask=00000000:00000000:00000000
[14800.683691] decode_server_caps: xdr returned 0!
[14800.684718] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.686581] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.688102] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.689884] RPC:       xs_tcp_send_request(128) = 0
[14800.690292] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.693183] svc: svc_authenticate (1)
[14800.693223] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.695871] svc: calling dispatcher
[14800.697064] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.700006] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.702920] RPC:       xs_data_ready...
[14800.704078] decode_attr_type: type=040000
[14800.705241] decode_attr_change: change attribute=6954294660659412992
[14800.706688] decode_attr_size: file size=154
[14800.707766] decode_attr_fsid: fsid=(0x0/0x0)
[14800.708819] decode_attr_fileid: fileid=256
[14800.709846] decode_attr_fs_locations: fs_locations done, error = 0
[14800.711117] decode_attr_mode: file mode=0755
[14800.712321] decode_attr_nlink: nlink=1
[14800.713304] decode_attr_owner: uid=0
[14800.714253] decode_attr_group: gid=0
[14800.715131] decode_attr_rdev: rdev=(0x0:0x0)
[14800.716079] decode_attr_space_used: space used=0
[14800.717089] decode_attr_time_access: atime=1619115491
[14800.718218] decode_attr_time_metadata: ctime=1618569204
[14800.719287] decode_attr_time_modify: mtime=1618569204
[14800.720315] decode_attr_mounted_on_fileid: fileid=1
[14800.721505] decode_getfattr_attrs: xdr returned 0
[14800.722631] decode_getfattr_generic: xdr returned 0
[14800.724122] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.726027] NFS: nfs_fhget(0:177/256 fh_crc=0x62d40c52 ct=1)
[14800.727814] NFS: permission(0:177/256), mask=0x81, res=-10
[14800.729995] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.731405] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.733497] RPC:       xs_tcp_send_request(136) = 0
[14800.733500] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.736136] svc: svc_authenticate (1)
[14800.736180] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.739234] svc: calling dispatcher
[14800.740138] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.742609] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.744470] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.746571] RPC:       xs_data_ready...
[14800.747584] decode_attr_type: type=00
[14800.748576] decode_attr_change: change attribute=6954294660659412992
[14800.749881] decode_attr_size: file size=154
[14800.750876] decode_attr_fsid: fsid=(0x0/0x0)
[14800.751873] decode_attr_fileid: fileid=0
[14800.753003] decode_attr_fs_locations: fs_locations done, error = 0
[14800.754249] decode_attr_mode: file mode=00
[14800.755185] decode_attr_nlink: nlink=1
[14800.756064] decode_attr_rdev: rdev=(0x0:0x0)
[14800.756982] decode_attr_space_used: space used=0
[14800.757981] decode_attr_time_access: atime=0
[14800.758876] decode_attr_time_metadata: ctime=1618569204
[14800.759867] decode_attr_time_modify: mtime=1618569204
[14800.760841] decode_attr_mounted_on_fileid: fileid=0
[14800.762046] decode_getfattr_attrs: xdr returned 0
[14800.763191] decode_getfattr_generic: xdr returned 0
[14800.764117] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.765290] NFS: nfs_update_inode(0:177/256 fh_crc=0x62d40c52 ct=2 info=0x26040)
[14800.766696] NFS: permission(0:177/256), mask=0x1, res=0
[14800.767916] NFS: lookup(/tmp)
[14800.769333] NFS call  lookup /tmp
[14800.770415] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=1024
[14800.772221] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[14800.774803] RPC:       xs_tcp_send_request(144) = 0
[14800.774846] svc: server 00000000b086fa8a, pool 0, transport 00000000b7a9b30d, inuse=2
[14800.777429] svc: svc_authenticate (1)
[14800.778439] svc: server 0000000002aec424, pool 0, transport 00000000b7a9b30d, inuse=3
[14800.780803] svc: calling dispatcher
[14800.781771] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.784033] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[14800.786220] nfsd: nfsd_lookup(fh 8: 00010001 00000000 00000000 00000000 00000000 00000000, tmp)
[14800.787811] RPC:       Want update, refage=120, age=0
[14800.789583] exp_export: export of non-dev fs without fsid
[14800.791151] RPC:       xs_data_ready...
[14800.792218] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[14800.793965] NFS reply lookup: -2
[14800.796355] NFS: dentry_delete(/tmp, 80c)
[14800.798250] NFS4: Couldn't follow remote path
[14800.799302] <-- nfs4_try_get_tree() = -2 [error]
[14800.801239] NFS: clear cookie (0x00000000fdcf48e1/0x0000000000000000)
[14800.804445] NFS: releasing superblock cookie (0x00000000f07d5f34/0x0000000000000000)
[14800.820712] NFS: destroy per-net callback data; net=f0000304
[14800.822199] RPC:       xs_tcp_state_change client 00000000b9cef903...
[14800.823702] RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
[14800.825162] RPC:       xs_data_ready...
[14800.826358] RPC:       xs_tcp_state_change client 00000000b9cef903...
[14800.827889] RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.828772] svc: svc_destroy(NFSv4 callback, 2)
[14800.829362] RPC:       xs_tcp_state_change client 00000000b9cef903...
[14800.832015] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.833436] RPC:       xs_tcp_state_change client 00000000b9cef903...
[14800.835001] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.836386] RPC:       xs_tcp_state_change client 00000000b9cef903...
[14800.836434] svc: svc_destroy(NFSv4 callback, 1)
[14800.837901] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.840374] nfs_callback_down: service destroyed
[14800.842234] NFS: releasing client cookie (0x00000000375cff7e/0x00000000c0f026bb)
[14800.844396] RPC:        destroy backchannel transport
[14800.845641] RPC:        backchannel list empty= true
[14800.846832] RPC:       xs_destroy xprt 000000004980c4c0
[14800.848049] RPC:       xs_close xprt 000000004980c4c0
[14800.849247] RPC:       xs_tcp_state_change client 000000004980c4c0...
[14800.850593] RPC:       state 4 conn 1 dead 0 zapped 1 sk_shutdown 3
[14800.858235] svc: server 00000000b086fa8a, pool 0, transport 00000000f25ede2b, inuse=2
[14800.859794] svc: svc_authenticate (0)
[14800.859806] svc: server 0000000002aec424, pool 0, transport 00000000f25ede2b, inuse=3
[14800.860842] svc: calling dispatcher
[14800.865076] NFS:   parsing nfs mount option 'source'
[14800.866299] NFS:   parsing nfs mount option 'addr'
[14800.867434] NFS:   parsing nfs mount option 'vers'
[14800.869168] NFS:   parsing nfs mount option 'proto'
[14800.870519] NFS:   parsing nfs mount option 'mountvers'
[14800.872284] NFS:   parsing nfs mount option 'mountproto'
[14800.874141] NFS:   parsing nfs mount option 'mountport'
[14800.875415] NFS: MNTPATH: '/tmp/ltp.nfs01.nfs-4/LTP_nfs01.ny7RbNMo0D/4/tcp'
[14800.877006] NFS: sending MNT request for 10.0.0.2:/tmp/ltp.nfs01.nfs-4/LTP_nfs01.ny7RbNMo0D/4/tcp
[14800.879436] RPC:       set up xprt to 10.0.0.2 (port 20048) via tcp
[14800.880931] RPC:       xs_connect scheduled xprt 00000000a9c1d171
[14800.882347] RPC:       xs_bind 0.0.0.0:817: ok (0)
[14800.883515] RPC:       worker connecting xprt 00000000a9c1d171 via tcp to 10.0.0.2 (port 20048)
[14800.885281] RPC:       xs_tcp_state_change client 00000000a9c1d171...
[14800.886700] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[14800.888081] RPC:       00000000a9c1d171 connect status 115 connected 1 sock state 1
[14800.890080] RPC:       xs_tcp_send_request(40) = 0
[14800.890230] RPC:       xs_data_ready...
[14800.892396] RPC:       xs_tcp_send_request(136) = 0
[14800.892819] nfsd: exp_rootfh(/tmp/ltp.nfs01.nfs-4/LTP_nfs01.ny7RbNMo0D/4/tcp [000000006b821e1e] *:tmpfs/7310)
[14800.895506] nfsd: fh_compose(exp 00:32/7310 4/tcp, ino=7310)
[14800.896885] RPC:       xs_data_ready...
[14800.898014] NFS: received 1 auth flavors
[14800.899151] NFS:   auth flavor[0]: 1
[14800.900123] NFS: MNT request succeeded
[14800.901099] NFS: attempting to use auth flavor 1
[14800.902226] RPC:        destroy backchannel transport
[14800.903431] RPC:        backchannel list empty= true
[14800.904839] RPC:       xs_destroy xprt 00000000a9c1d171
[14800.905284] NFS: get client cookie (0x000000006b121986/0x00000000ae4f1e65)
[14800.906087] RPC:       xs_close xprt 00000000a9c1d171
[14800.907505] RPC:       set up xprt to 10.0.0.2 (autobind) via tcp
[14800.910209] RPC:       xs_tcp_state_change client 00000000a9c1d171...
[14800.910343] RPC:       set up xprt to 10.0.0.2 (port 111) via tcp
[14800.911509] RPC:       state 4 conn 1 dead 0 zapped 1 sk_shutdown 3
[14800.914246] RPC:       xs_tcp_state_change client 00000000a9c1d171...
[14800.915516] RPC:       state 5 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.916838] RPC:       xs_tcp_state_change client 00000000a9c1d171...
[14800.917207] RPC:       xs_connect scheduled xprt 00000000f9895d79
[14800.918155] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.919363] RPC:       worker connecting xprt 00000000f9895d79 via tcp to 10.0.0.2 (port 111)
[14800.920665] RPC:       xs_tcp_state_change client 00000000a9c1d171...
[14800.920667] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.920668] RPC:       xs_data_ready...
[14800.926561] RPC:       xs_tcp_state_change client 00000000f9895d79...
[14800.927941] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[14800.929215] RPC:       00000000f9895d79 connect status 115 connected 1 sock state 1
[14800.930761] RPC:       xs_tcp_send_request(96) = 0
[14800.930852] RPC:       xs_data_ready...
[14800.933674] RPC:       setting port for xprt 0000000011a852a8 to 2049
[14800.935625] RPC:        destroy backchannel transport
[14800.936806] RPC:        backchannel list empty= true
[14800.938032] RPC:       xs_destroy xprt 00000000f9895d79
[14800.939134] RPC:       xs_close xprt 00000000f9895d79
[14800.940237] RPC:       xs_tcp_state_change client 00000000f9895d79...
[14800.940325] RPC:       xs_connect scheduled xprt 0000000011a852a8
[14800.941582] RPC:       state 4 conn 1 dead 0 zapped 1 sk_shutdown 3
[14800.941587] RPC:       xs_tcp_state_change client 00000000f9895d79...
[14800.944605] RPC:       xs_bind 0.0.0.0:752: ok (0)
[14800.945746] RPC:       state 5 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.946941] RPC:       worker connecting xprt 0000000011a852a8 via tcp to 10.0.0.2 (port 2049)
[14800.948135] RPC:       xs_tcp_state_change client 00000000f9895d79...
[14800.949759] RPC:       xs_tcp_state_change client 0000000011a852a8...
[14800.951304] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.952740] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[14800.953992] RPC:       xs_tcp_state_change client 00000000f9895d79...
[14800.955310] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14800.956450] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.958113] RPC:       0000000011a852a8 connect status 115 connected 1 sock state 1
[14800.959338] RPC:       xs_data_ready...
[14800.960810] RPC:       xs_tcp_send_request(40) = 0
[14800.964247] svc: svc_authenticate (0)
[14800.964289] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14800.965237] svc: calling dispatcher
[14800.967725] RPC:       xs_data_ready...
[14800.968695] RPC:       worker connecting xprt 000000004980c4c0 via AF_LOCAL to /var/run/rpcbind.sock
[14800.969287] RPC:       xs_tcp_state_change client 00000000f9895d79...
[14800.970437] RPC:       xprt 000000004980c4c0 connected to /var/run/rpcbind.sock
[14800.971698] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14800.973318] RPC:       set up xprt to /var/run/rpcbind.sock via AF_LOCAL
[14800.976080] RPC:       xs_local_send_request(40) = 0
[14800.976272] RPC:       xs_data_ready...
[14800.978959] RPC:       xs_local_send_request(40) = 0
[14800.979002] RPC:       xs_data_ready...
[14800.981921] RPC:       xs_local_send_request(64) = 0
[14800.982580] RPC:       xs_data_ready...
[14800.984412] RPC:       xs_local_send_request(64) = 0
[14800.984462] RPC:       xs_data_ready...
[14800.986646] RPC:       xs_local_send_request(64) = 0
[14800.987141] RPC:       xs_data_ready...
[14800.989470] RPC:       xs_local_send_request(84) = 0
[14800.989511] RPC:       xs_data_ready...
[14800.992059] RPC:       xs_local_send_request(84) = 0
[14800.992116] RPC:       xs_data_ready...
[14800.994784] RPC:       xs_local_send_request(84) = 0
[14800.995175] RPC:       xs_data_ready...
[14800.997352] svc: server 000000004d3956fa, pool 0, transport 0000000052605e92, inuse=2
[14800.999424] RPC:       xs_local_send_request(84) = 0
[14800.999485] RPC:       xs_data_ready...
[14801.002638] RPC:       xs_local_send_request(84) = 0
[14801.002703] RPC:       xs_data_ready...
[14801.005407] RPC:       xs_local_send_request(84) = 0
[14801.005449] RPC:       xs_data_ready...
[14801.007816] RPC:       xs_local_send_request(80) = 0
[14801.007867] RPC:       xs_data_ready...
[14801.010230] RPC:       xs_local_send_request(80) = 0
[14801.010831] RPC:       xs_data_ready...
[14801.013165] RPC:       xs_local_send_request(80) = 0
[14801.013237] RPC:       xs_data_ready...
[14801.015507] svc: server 000000004d3956fa, pool 0, transport 0000000026ef78d5, inuse=2
[14801.017588] RPC:       xs_local_send_request(80) = 0
[14801.017751] RPC:       xs_data_ready...
[14801.019793] RPC:       xs_local_send_request(80) = 0
[14801.019874] RPC:       xs_data_ready...
[14801.022126] RPC:       xs_local_send_request(80) = 0
[14801.022701] RPC:       xs_data_ready...
[14801.024846] svc: svc_destroy(lockd, 2)
[14801.025871] RPC:       set up xprt to 10.0.0.2 (autobind) via tcp
[14801.027229] NFS call  fsinfo
[14801.028101] RPC:       xs_tcp_send_request(96) = 0
[14801.028146] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.030695] svc: svc_authenticate (1)
[14801.030702] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.031618] svc: calling dispatcher
[14801.034034] nfsd: FSINFO(3)   8: 00010001 00007805 00000000 00000000 00000000 00000000
[14801.035615] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14801.038093] RPC:       Want update, refage=120, age=0
[14801.039871] found domain *
[14801.040689] found fsidtype 1
[14801.041488] found fsid length 4
[14801.042603] Path seems to be </tmp/ltp.nfs01.nfs-4/LTP_nfs01.ny7RbNMo0D/4/tcp>
[14801.043967] Found the path /tmp/ltp.nfs01.nfs-4/LTP_nfs01.ny7RbNMo0D/4/tcp
[14801.046055] RPC:       xs_data_ready...
[14801.047745] NFS reply fsinfo: 0
[14801.048737] NFS call  pathconf
[14801.050909] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.052513] svc: svc_authenticate (1)
[14801.052604] RPC:       xs_tcp_send_request(96) = 0
[14801.053463] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.057360] svc: calling dispatcher
[14801.058309] nfsd: PATHCONF(3) 8: 00010001 00007805 00000000 00000000 00000000 00000000
[14801.059862] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14801.062640] RPC:       xs_data_ready...
[14801.063900] NFS reply pathconf: 0
[14801.064912] NFS call  getattr
[14801.066134] RPC:       xs_tcp_send_request(96) = 0
[14801.066171] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.069348] svc: svc_authenticate (1)
[14801.070417] svc: calling dispatcher
[14801.070416] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.071403] nfsd: GETATTR(3)  8: 00010001 00007805 00000000 00000000 00000000 00000000
[14801.074803] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14801.076993] RPC:       xs_data_ready...
[14801.078157] NFS reply getattr: 0
[14801.079134] Server FSID: 7805:0
[14801.080173] RPC:       xs_tcp_send_request(40) = 0
[14801.082031] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.083697] svc: svc_authenticate (0)
[14801.083741] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.084705] svc: calling dispatcher
[14801.084734] RPC:       xs_data_ready...
[14801.088899] do_proc_get_root: call  fsinfo
[14801.090168] RPC:       xs_tcp_send_request(96) = 0
[14801.090179] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.092963] svc: svc_authenticate (1)
[14801.093567] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.093995] svc: calling dispatcher
[14801.096599] nfsd: FSINFO(3)   8: 00010001 00007805 00000000 00000000 00000000 00000000
[14801.098276] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14801.100449] RPC:       xs_data_ready...
[14801.102712] do_proc_get_root: reply fsinfo: 0
[14801.103899] RPC:       xs_tcp_send_request(96) = 0
[14801.103909] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.106714] svc: svc_authenticate (1)
[14801.106763] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.108849] svc: calling dispatcher
[14801.110560] nfsd: GETATTR(3)  8: 00010001 00007805 00000000 00000000 00000000 00000000
[14801.112146] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14801.114923] RPC:       xs_data_ready...
[14801.116087] do_proc_get_root: reply getattr: 0
[14801.118023] NFS: nfs_fhget(0:177/7310 fh_crc=0x0fe8c588 ct=1)
[14801.126002] NFS: nfs_weak_revalidate: inode 7310 is valid
[14801.127314] NFS: nfs_weak_revalidate: inode 7310 is valid
[14801.128589] NFS call  access
[14801.129585] RPC:       xs_tcp_send_request(100) = 0
[14801.130764] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14801.132332] svc: svc_authenticate (1)
[14801.132377] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14801.133407] svc: calling dispatcher
[14801.135973] nfsd: ACCESS(3)   8: 00010001 00007805 00000000 00000000 00000000 00000000 0x1f
[14801.137542] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14801.139900] RPC:       xs_data_ready...
...
[14915.174477] NFS: nfs_update_inode(0:177/7310 fh_crc=0x0fe8c588 ct=2 info=0x27e7f)
[14915.176367] NFS: (0:177/7310) revalidation complete
[14915.177702] NFS: nfs_weak_revalidate: inode 7310 is valid
[14915.179100] NFS: permission(0:177/7310), mask=0x24, res=0
[14915.180614] NFS: open dir(/)
[14915.183496] NFS: nfs_weak_revalidate: inode 7310 is valid
[14915.185979] NFS: readdir(/) starting at cookie 0
[14915.189249] NFS: nfs_do_filldir() filling ended @ cookie 127
[14915.191854] NFS: nfs_do_filldir() filling ended @ cookie 254
[14915.193412] NFS: nfs_do_filldir() filling ended @ cookie 381
[14915.194895] NFS: nfs_do_filldir() filling ended @ cookie 508
[14915.197265] NFS: nfs_do_filldir() filling ended @ cookie 635
[14915.198721] NFS: nfs_do_filldir() filling ended @ cookie 762
[14915.201117] NFS: nfs_do_filldir() filling ended @ cookie 889
[14915.203767] NFS: nfs_do_filldir() filling ended @ cookie 1002
[14915.205363] NFS: readdir(/) returns 0
[14915.206898] NFS: readdir(/) starting at cookie 1002
[14915.208769] NFS: readdir(/) returns 0
[14915.215462] NFS: nfs_weak_revalidate: inode 7310 is valid
[14915.217845] NFS: nfs_weak_revalidate: inode 7310 is valid
[14915.220055] NFS call  fsstat
[14915.221310] svc: server 00000000b086fa8a, pool 0, transport 00000000ea621c47, inuse=2
[14915.223020] svc: svc_authenticate (1)
[14915.225255] svc: server 0000000002aec424, pool 0, transport 00000000ea621c47, inuse=3
[14915.226911] RPC:       xs_tcp_send_request(96) = 0
[14915.227238] RPC:       Want update, refage=120, age=115
[14915.230027] svc: calling dispatcher
[14915.231301] nfsd: FSSTAT(3)   8: 00010001 00007805 00000000 00000000 00000000 00000000
[14915.233507] nfsd: fh_verify(8: 00010001 00007805 00000000 00000000 00000000 00000000)
[14915.236729] RPC:       xs_data_ready...
[14915.239221] NFS reply fsstat: 0
[14915.246263] NFS: nfs_weak_revalidate: inode 7310 is valid
[14915.255495] NFS: clear cookie (0x00000000d9d434fd/0x0000000000000000)
[14915.258423] NFS: clear cookie (0x0000000061e9c1e7/0x0000000000000000)
[14917.184910] NFS: clear cookie (0x000000000dbe2efa/0x0000000000000000)
...
[14917.186215] NFS: clear cookie (0x00000000253d681d/0x0000000000000000)
[14917.187631] NFS: clear cookie (0x0000000030cc97f8/0x0000000000000000)
[14917.190376] NFS: releasing superblock cookie (0x00000000e2c01c59/0x0000000000000000)
[14917.207498] RPC:        destroy backchannel transport
[14917.209349] RPC:        backchannel list empty= true
[14917.211033] RPC:       xs_destroy xprt 0000000047412e6a
[14917.212928] RPC:       xs_close xprt 0000000047412e6a
[14917.219492] RPC:       xs_local_send_request(64) = 0
[14917.220887] RPC:       xs_data_ready...
[14917.222317] RPC:       xs_local_send_request(64) = 0
[14917.225222] RPC:       xs_data_ready...
[14917.226733] RPC:       xs_local_send_request(64) = 0
[14917.227883] RPC:       xs_data_ready...
[14917.228929] RPC:       xs_destroy xprt 000000004980c4c0
[14917.230225] RPC:       xs_close xprt 000000004980c4c0
[14917.231730] NFS: releasing client cookie (0x000000006b121986/0x00000000ae4f1e65)
[14917.235457] RPC:        destroy backchannel transport
[14917.236711] RPC:        backchannel list empty= true
[14917.237952] RPC:       xs_destroy xprt 0000000011a852a8
[14917.239223] RPC:       xs_close xprt 0000000011a852a8
[14917.240676] RPC:       xs_tcp_state_change client 0000000011a852a8...
[14917.242100] RPC:       state 4 conn 1 dead 0 zapped 1 sk_shutdown 3
[14917.243546] RPC:       xs_tcp_state_change client 0000000011a852a8...
[14917.245200] RPC:       state 5 conn 0 dead 0 zapped 1 sk_shutdown 3
[14917.246635] RPC:       xs_tcp_state_change client 0000000011a852a8...
[14917.248102] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14917.249849] RPC:       xs_tcp_state_change client 0000000011a852a8...
[14917.251480] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[14917.253001] RPC:       xs_data_ready...
[14917.254049] RPC:       xs_tcp_state_change client 0000000011a852a8...
[14917.255689] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3

Kind regards,
Petr
