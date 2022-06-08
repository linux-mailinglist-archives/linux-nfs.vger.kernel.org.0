Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606D543A03
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiFHROX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 8 Jun 2022 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiFHROC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jun 2022 13:14:02 -0400
Received: from mail.linux-ng.de (srv.linux-ng.de [IPv6:2a01:4f8:160:92e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40720249323
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jun 2022 09:59:29 -0700 (PDT)
Received: from cloud.linux-ng.de (srv.linux-ng.de [IPv6:2a01:4f8:160:92e6::2])
        by mail.linux-ng.de (Postfix) with ESMTPSA id 1A69D841D565
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jun 2022 18:59:28 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 08 Jun 2022 16:59:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.16.0
From:   marcel@linux-ng.de
Message-ID: <fc9862d27cdf732e305bc6d1800bdf2a@linux-ng.de>
Subject: Re: [PATCH 1/3] cifs-utils/svcgssd: Fix use-after-free bug
 (config variables)
To:     linux-nfs@vger.kernel.org
In-Reply-To: <20220607081909.1216287-1-marcel@linux-ng.de>
References: <20220607081909.1216287-1-marcel@linux-ng.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi again,

argl - just noticed that I described the patches with "cifs-utils" - should be "nfs-utils" of course :-(
Sorry for that.

Marcel


June 7, 2022 10:19 AM, marcel@linux-ng.de wrote:

> From: Marcel Ritter <marcel@linux-ng.de>
> 
> This patch fixes a bug when trying to set "principal" in /etc/nfs.conf.
> Memory gets freed by conf_cleanup() before being used - moving cleanup
> code resolves that.
> 
> ---
> utils/gssd/svcgssd.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
> index 881207b3..a242b789 100644
> --- a/utils/gssd/svcgssd.c
> +++ b/utils/gssd/svcgssd.c
> @@ -211,9 +211,6 @@ main(int argc, char *argv[])
> rpc_verbosity = conf_get_num("svcgssd", "RPC-Verbosity", rpc_verbosity);
> idmap_verbosity = conf_get_num("svcgssd", "IDMAP-Verbosity", idmap_verbosity);
> 
> - /* We don't need the config anymore */
> - conf_cleanup();
> -
> while ((opt = getopt(argc, argv, "fivrnp:")) != -1) {
> switch (opt) {
> case 'f':
> @@ -328,6 +325,9 @@ main(int argc, char *argv[])
> 
> daemon_ready();
> 
> + /* We don't need the config anymore */
> + conf_cleanup();
> +
> nfs4_init_name_mapping(NULL); /* XXX: should only do this once */
> 
> rc = event_base_dispatch(evbase);
> -- 
> 2.34.1
