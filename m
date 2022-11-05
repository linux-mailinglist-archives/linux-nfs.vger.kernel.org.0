Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C2261D7BE
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Nov 2022 07:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKEGBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Nov 2022 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKEGBe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Nov 2022 02:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5930F77;
        Fri,  4 Nov 2022 23:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 430636098A;
        Sat,  5 Nov 2022 06:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E891EC43470;
        Sat,  5 Nov 2022 06:01:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orCFi-007OoQ-0O;
        Sat, 05 Nov 2022 02:01:58 -0400
Message-ID: <20221105060157.958177534@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Nov 2022 02:00:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH v4a 17/38] timers: net: Use timer_shutdown_sync() before freeing timer
References: <20221105060024.598488967@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, timer_shutdown_sync() must be called.

And if synchronization is already done, then at least timer_shutdown()
needs to be called.

Link: https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Mirko Lindner <mlindner@marvell.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Menglong Dong <imagedong@tencent.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: bridge@lists.linux-foundation.org
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: lvs-devel@vger.kernel.org
Cc: linux-afs@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c      | 7 +++----
 drivers/net/ethernet/marvell/sky2.c              | 2 +-
 drivers/net/ethernet/sun/sunvnet.c               | 2 +-
 drivers/net/usb/sierra_net.c                     | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 2 +-
 drivers/net/wireless/intersil/hostap/hostap_ap.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/main.c      | 2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c    | 6 +++---
 net/802/garp.c                                   | 2 +-
 net/802/mrp.c                                    | 2 +-
 net/bridge/br_multicast.c                        | 6 +++---
 net/bridge/br_multicast_eht.c                    | 4 ++--
 net/core/gen_estimator.c                         | 2 +-
 net/core/neighbour.c                             | 2 ++
 net/ipv4/inet_timewait_sock.c                    | 1 +
 net/ipv4/ipmr.c                                  | 2 +-
 net/ipv6/ip6mr.c                                 | 2 +-
 net/mac80211/mesh_pathtbl.c                      | 2 +-
 net/netfilter/ipset/ip_set_list_set.c            | 2 +-
 net/netfilter/ipvs/ip_vs_lblc.c                  | 2 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                 | 2 +-
 net/netfilter/xt_LED.c                           | 2 +-
 net/rxrpc/conn_object.c                          | 2 +-
 net/sched/cls_flow.c                             | 2 +-
 net/sunrpc/svc.c                                 | 2 +-
 net/tipc/discover.c                              | 2 +-
 net/tipc/monitor.c                               | 2 +-
 27 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b5dcd15ced36..0b534d3ef3bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15530,7 +15530,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 
 err_switch_setup:
 	i40e_reset_interrupt_capability(pf);
-	del_timer_sync(&pf->service_timer);
+	timer_shutdown_sync(&pf->service_timer);
 	i40e_shutdown_adminq(hw);
 	iounmap(hw->hw_addr);
 	pci_disable_pcie_error_reporting(pf->pdev);
@@ -16149,7 +16149,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(pf->vsi);
 err_switch_setup:
 	i40e_reset_interrupt_capability(pf);
-	del_timer_sync(&pf->service_timer);
+	timer_shutdown_sync(&pf->service_timer);
 err_mac_addr:
 err_configure_lan_hmc:
 	(void)i40e_shutdown_lan_hmc(hw);
@@ -16210,8 +16210,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	/* no more scheduling of any task */
 	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
-	if (pf->service_timer.function)
-		del_timer_sync(&pf->service_timer);
+	timer_shutdown_sync(&pf->service_timer);
 	if (pf->service_task.func)
 		cancel_work_sync(&pf->service_task);
 
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index ab33ba1c3023..dc571e076180 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5013,7 +5013,7 @@ static void sky2_remove(struct pci_dev *pdev)
 	if (!hw)
 		return;
 
-	del_timer_sync(&hw->watchdog_timer);
+	timer_shutdown_sync(&hw->watchdog_timer);
 	cancel_work_sync(&hw->restart_work);
 
 	for (i = hw->ports-1; i >= 0; --i)
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index acda6cbd0238..fe86fbd58586 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -524,7 +524,7 @@ static void vnet_port_remove(struct vio_dev *vdev)
 		hlist_del_rcu(&port->hash);
 
 		synchronize_rcu();
-		del_timer_sync(&port->clean_timer);
+		timer_shutdown_sync(&port->clean_timer);
 		sunvnet_port_rm_txq_common(port);
 		netif_napi_del(&port->napi);
 		sunvnet_port_free_tx_bufs_common(port);
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index b3ae949e6f1c..673d3aa83792 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -759,7 +759,7 @@ static void sierra_net_unbind(struct usbnet *dev, struct usb_interface *intf)
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 
 	/* kill the timer and work */
-	del_timer_sync(&priv->sync_timer);
+	timer_shutdown_sync(&priv->sync_timer);
 	cancel_work_sync(&priv->sierra_net_kevent);
 
 	/* tell modem we are going away */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3237d4b528b5..119d83acafd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -371,7 +371,7 @@ void iwl_dbg_tlv_del_timers(struct iwl_trans *trans)
 	struct iwl_dbg_tlv_timer_node *node, *tmp;
 
 	list_for_each_entry_safe(node, tmp, timer_list, list) {
-		del_timer_sync(&node->timer);
+		timer_shutdown_sync(&node->timer);
 		list_del(&node->list);
 		kfree(node);
 	}
diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
index 462ccc7d7d1a..9b546a71e7a2 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
@@ -135,7 +135,7 @@ static void ap_free_sta(struct ap_data *ap, struct sta_info *sta)
 
 	if (!sta->ap)
 		kfree(sta->u.sta.challenge);
-	del_timer_sync(&sta->timer);
+	timer_shutdown_sync(&sta->timer);
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 	kfree(sta);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index da2e6557e684..ea22a08e6c08 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -123,7 +123,7 @@ static int mwifiex_unregister(struct mwifiex_adapter *adapter)
 	if (adapter->if_ops.cleanup_if)
 		adapter->if_ops.cleanup_if(adapter);
 
-	del_timer_sync(&adapter->cmd_timer);
+	timer_shutdown_sync(&adapter->cmd_timer);
 
 	/* Free private structures */
 	for (i = 0; i < adapter->priv_num; i++) {
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index eb1d1ba3a443..131f9fd97c37 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1520,10 +1520,10 @@ int wilc_deinit(struct wilc_vif *vif)
 
 	mutex_lock(&vif->wilc->deinit_lock);
 
-	del_timer_sync(&hif_drv->scan_timer);
-	del_timer_sync(&hif_drv->connect_timer);
+	timer_shutdown_sync(&hif_drv->scan_timer);
+	timer_shutdown_sync(&hif_drv->connect_timer);
 	del_timer_sync(&vif->periodic_rssi);
-	del_timer_sync(&hif_drv->remain_on_ch_timer);
+	timer_shutdown_sync(&hif_drv->remain_on_ch_timer);
 
 	if (hif_drv->usr_scan_req.scan_result) {
 		hif_drv->usr_scan_req.scan_result(SCAN_EVENT_ABORTED, NULL,
diff --git a/net/802/garp.c b/net/802/garp.c
index fc9eb02a912f..87b2ddfe86ac 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -618,7 +618,7 @@ void garp_uninit_applicant(struct net_device *dev, struct garp_application *appl
 
 	/* Delete timer and generate a final TRANSMIT_PDU event to flush out
 	 * all pending messages before the applicant is gone. */
-	del_timer_sync(&app->join_timer);
+	timer_shutdown_sync(&app->join_timer);
 
 	spin_lock_bh(&app->lock);
 	garp_gid_event(app, GARP_EVENT_TRANSMIT_PDU);
diff --git a/net/802/mrp.c b/net/802/mrp.c
index 155f74d8b14f..a744a28477dd 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -904,7 +904,7 @@ void mrp_uninit_applicant(struct net_device *dev, struct mrp_application *appl)
 	 * all pending messages before the applicant is gone.
 	 */
 	del_timer_sync(&app->join_timer);
-	del_timer_sync(&app->periodic_timer);
+	timer_shutdown_sync(&app->periodic_timer);
 
 	spin_lock_bh(&app->lock);
 	mrp_mad_event(app, MRP_EVENT_TX);
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index db4f2641d1cd..16d2a7064e44 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -605,7 +605,7 @@ static void br_multicast_destroy_mdb_entry(struct net_bridge_mcast_gc *gc)
 	WARN_ON(!hlist_unhashed(&mp->mdb_node));
 	WARN_ON(mp->ports);
 
-	del_timer_sync(&mp->timer);
+	timer_shutdown_sync(&mp->timer);
 	kfree_rcu(mp, rcu);
 }
 
@@ -646,7 +646,7 @@ static void br_multicast_destroy_group_src(struct net_bridge_mcast_gc *gc)
 	src = container_of(gc, struct net_bridge_group_src, mcast_gc);
 	WARN_ON(!hlist_unhashed(&src->node));
 
-	del_timer_sync(&src->timer);
+	timer_shutdown_sync(&src->timer);
 	kfree_rcu(src, rcu);
 }
 
@@ -671,7 +671,7 @@ static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 	WARN_ON(!hlist_empty(&pg->src_list));
 
 	del_timer_sync(&pg->rexmit_timer);
-	del_timer_sync(&pg->timer);
+	timer_shutdown_sync(&pg->timer);
 	kfree_rcu(pg, rcu);
 }
 
diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index f91c071d1608..c126aa4e7551 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -142,7 +142,7 @@ static void br_multicast_destroy_eht_set_entry(struct net_bridge_mcast_gc *gc)
 	set_h = container_of(gc, struct net_bridge_group_eht_set_entry, mcast_gc);
 	WARN_ON(!RB_EMPTY_NODE(&set_h->rb_node));
 
-	del_timer_sync(&set_h->timer);
+	timer_shutdown_sync(&set_h->timer);
 	kfree(set_h);
 }
 
@@ -154,7 +154,7 @@ static void br_multicast_destroy_eht_set(struct net_bridge_mcast_gc *gc)
 	WARN_ON(!RB_EMPTY_NODE(&eht_set->rb_node));
 	WARN_ON(!RB_EMPTY_ROOT(&eht_set->entry_tree));
 
-	del_timer_sync(&eht_set->timer);
+	timer_shutdown_sync(&eht_set->timer);
 	kfree(eht_set);
 }
 
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index 4fcbdd71c59f..fae9c4694186 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -208,7 +208,7 @@ void gen_kill_estimator(struct net_rate_estimator __rcu **rate_est)
 
 	est = xchg((__force struct net_rate_estimator **)rate_est, NULL);
 	if (est) {
-		del_timer_sync(&est->timer);
+		timer_shutdown_sync(&est->timer);
 		kfree_rcu(est, rcu);
 	}
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3c4786b99907..68edfd46781c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -895,6 +895,8 @@ void neigh_destroy(struct neighbour *neigh)
 	if (neigh_del_timer(neigh))
 		pr_warn("Impossible event\n");
 
+	timer_shutdown(&neigh->timer);
+
 	write_lock_bh(&neigh->lock);
 	__skb_queue_purge(&neigh->arp_queue);
 	write_unlock_bh(&neigh->lock);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 66fc940f9521..ee3942af9950 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -66,6 +66,7 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
 	struct module *owner = tw->tw_prot->owner;
+	timer_shutdown(&tw->tw_timer);
 	twsk_destructor((struct sock *)tw);
 #ifdef SOCK_REFCNT_DEBUG
 	pr_debug("%s timewait_sock %p released\n", tw->tw_prot->name, tw);
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e04544ac4b45..dbaf4c33b155 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -412,7 +412,7 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 
 static void ipmr_free_table(struct mr_table *mrt)
 {
-	del_timer_sync(&mrt->ipmr_expire_timer);
+	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
 				 MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC);
 	rhltable_destroy(&mrt->mfc_hash);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index facdc78a43e5..474b862039e0 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -392,7 +392,7 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 
 static void ip6mr_free_table(struct mr_table *mrt)
 {
-	del_timer_sync(&mrt->ipmr_expire_timer);
+	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
 	rhltable_destroy(&mrt->mfc_hash);
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index acc1c299f1ae..ec72756075f5 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -512,7 +512,7 @@ static void mesh_path_free_rcu(struct mesh_table *tbl,
 	mpath->flags |= MESH_PATH_RESOLVING | MESH_PATH_DELETED;
 	mesh_gate_del(tbl, mpath);
 	spin_unlock_bh(&mpath->state_lock);
-	del_timer_sync(&mpath->timer);
+	timer_shutdown_sync(&mpath->timer);
 	atomic_dec(&sdata->u.mesh.mpaths);
 	atomic_dec(&tbl->entries);
 	mesh_path_flush_pending(mpath);
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 5a67f7966574..e162636525cf 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -427,7 +427,7 @@ list_set_destroy(struct ip_set *set)
 	struct set_elem *e, *n;
 
 	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
+		timer_shutdown_sync(&map->gc);
 
 	list_for_each_entry_safe(e, n, &map->members, list) {
 		list_del(&e->list);
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 7ac7473e3804..1b87214d385e 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -384,7 +384,7 @@ static void ip_vs_lblc_done_svc(struct ip_vs_service *svc)
 	struct ip_vs_lblc_table *tbl = svc->sched_data;
 
 	/* remove periodic timer */
-	del_timer_sync(&tbl->periodic_timer);
+	timer_shutdown_sync(&tbl->periodic_timer);
 
 	/* got to clean up table entries here */
 	ip_vs_lblc_flush(svc);
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 77c323c36a88..ad8f5fea6d3a 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -547,7 +547,7 @@ static void ip_vs_lblcr_done_svc(struct ip_vs_service *svc)
 	struct ip_vs_lblcr_table *tbl = svc->sched_data;
 
 	/* remove periodic timer */
-	del_timer_sync(&tbl->periodic_timer);
+	timer_shutdown_sync(&tbl->periodic_timer);
 
 	/* got to clean up table entries here */
 	ip_vs_lblcr_flush(svc);
diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index 0371c387b0d1..66b0f941d8fb 100644
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -166,7 +166,7 @@ static void led_tg_destroy(const struct xt_tgdtor_param *par)
 
 	list_del(&ledinternal->list);
 
-	del_timer_sync(&ledinternal->timer);
+	timer_shutdown_sync(&ledinternal->timer);
 
 	led_trigger_unregister(&ledinternal->netfilter_led_trigger);
 
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 22089e37e97f..307d6d480e78 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -358,7 +358,7 @@ static void rxrpc_destroy_connection(struct rcu_head *rcu)
 
 	_net("DESTROY CONN %d", conn->debug_id);
 
-	del_timer_sync(&conn->timer);
+	timer_shutdown_sync(&conn->timer);
 	rxrpc_purge_queue(&conn->rx_queue);
 
 	conn->security->clear(conn);
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 014cd3de7b5d..cd90a3083b9f 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -367,7 +367,7 @@ static const struct nla_policy flow_policy[TCA_FLOW_MAX + 1] = {
 
 static void __flow_destroy_filter(struct flow_filter *f)
 {
-	del_timer_sync(&f->perturb_timer);
+	timer_shutdown_sync(&f->perturb_timer);
 	tcf_exts_destroy(&f->exts);
 	tcf_em_tree_destroy(&f->ematches);
 	tcf_exts_put_net(&f->exts);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 149171774bc6..42663e240ec5 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -567,7 +567,7 @@ svc_destroy(struct kref *ref)
 	struct svc_serv *serv = container_of(ref, struct svc_serv, sv_refcnt);
 
 	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
-	del_timer_sync(&serv->sv_temptimer);
+	timer_shutdown_sync(&serv->sv_temptimer);
 
 	/*
 	 * The last user is gone and thus all sockets have to be destroyed to
diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index e8630707901e..d9efbee90fb4 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -385,7 +385,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
  */
 void tipc_disc_delete(struct tipc_discoverer *d)
 {
-	del_timer_sync(&d->timer);
+	timer_shutdown_sync(&d->timer);
 	kfree_skb(d->skb);
 	kfree(d);
 }
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 9618e4429f0f..77a3d016cade 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -700,7 +700,7 @@ void tipc_mon_delete(struct net *net, int bearer_id)
 	}
 	mon->self = NULL;
 	write_unlock_bh(&mon->lock);
-	del_timer_sync(&mon->timer);
+	timer_shutdown_sync(&mon->timer);
 	kfree(self->domain);
 	kfree(self);
 	kfree(mon);
-- 
2.35.1
