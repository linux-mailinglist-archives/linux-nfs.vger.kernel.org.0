Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED661570EEC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 02:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiGLAWU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 20:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiGLAVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 20:21:48 -0400
X-Greylist: delayed 1389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 17:21:33 PDT
Received: from qproxy5-pub.mail.unifiedlayer.com (qproxy5-pub.mail.unifiedlayer.com [69.89.21.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0B29809
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 17:21:33 -0700 (PDT)
Received: from progateway7-pub.mail.pro1.eigbox.com (gproxy5-pub.mail.unifiedlayer.com [67.222.38.55])
        by qproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 1A6B3801F6AB
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 23:58:14 +0000 (UTC)
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway7.mail.pro1.eigbox.com (Postfix) with ESMTP id 5A21310042D19
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 23:57:52 +0000 (UTC)
Received: from box5856.bluehost.com ([162.241.24.80])
        by cmsmtp with ESMTP
        id B3Hjo2uw5Wg0EB3Hko4Gap; Mon, 11 Jul 2022 23:57:52 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Y4w9DjSN c=1 sm=1 tr=0 ts=62ccb900
 a=P3sV0i4S5nnDiJSpMmgoGA==:117 a=P3sV0i4S5nnDiJSpMmgoGA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=d9hfteV3g8oA:10:x_php_script_1 a=96GJKQGblXAA:10:x_php_script_2
 a=RgO8CyIxsXoA:10:nop_rcvd_month_year a=gMiy2mu95-EA:10:ip_php_script_1
 a=LgjKu7UxGLAA:10:endurance_base64_authed_username_1 a=kMF6tg4kAAAA:8
 a=VwQbUJbxAAAA:8 a=ebvJoV9NAAAA:8 a=9bFcg3lofPhzA63ryPoA:9
 a=QEXdDO2ut3YA:10:nop_charset_2 a=8kQ_f1rJiAEA:10:unanchored_sms_domain1
 a=-FEs8UIgK8oA:10:nop_fastflux_domain_1
 a=VxAk22fqlfwA:10:nop_delegated_string_gtld_1 a=tWpsG8_5hk2-Qd6Hdv2S:22
 a=AjGcO6oz07-iQ99wixmX:22 a=I8zOroQLTF56daIS_Oxq:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ruachmilwaukee.org; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:From:Date:Subject:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FwIpYQzlLC4Bx3+BTULm3zYDb1O9Sj6z9C0WxHFc258=; b=IepJAGUIVHU7r0tquFK/9AMdet
        jjSmeQsuKiv4e6qAFuhL3+9bzH8nCrlUzYa+ovEm7lEp2QxJAUfHH85W7T1/d+D0P/9gGPtCjkOec
        r92LilMh3qDY60rt3S9vsSyZ0;
Received: from ruachmil by box5856.bluehost.com with local (Exim 4.95)
        (envelope-from <ruachmil@box5856.bluehost.com>)
        id 1oB3Hj-001SBo-Op
        for linux-nfs@vger.kernel.org;
        Mon, 11 Jul 2022 17:57:51 -0600
To:     linux-nfs@vger.kernel.org
Subject: [text your-subject]
X-PHP-Script: ruachmilwaukee.org/index.php for 109.70.100.30
X-PHP-Originating-Script: 1462:PHPMailer.php
Date:   Mon, 11 Jul 2022 23:57:51 +0000
From:   WordPress <richman.j@ruachmilwaukee.org>
Message-ID: <EJV7Ci96TQmc3aRzX8km6Ezt2vFucfq05Vfxi8cWYiw@ruachmilwaukee.org>
X-Mailer: PHPMailer 6.6.0 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5856.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1462 993] / [47 12]
X-AntiAbuse: Sender Address Domain - box5856.bluehost.com
X-BWhitelist: no
X-Source-IP: 
X-Source-L: No
X-Exim-ID: 1oB3Hj-001SBo-Op
X-Source: 
X-Source-Args: 
X-Source-Dir: ruachmilwaukee.org:/public_html
X-Source-Sender: 
X-Source-Auth: ruachmil
X-Email-Count: 119
X-Source-Cap: cnVhY2htaWw7cnVhY2htaWw7Ym94NTg1Ni5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SHORT_SHORTNER,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: 🤍 Beatrice sent you a private message! View Message: https://letsg0dancing.page.link/go?6jf9 🤍 <linux-nfs@vger.kernel.org>
Subject: dbug4n

Message Body:
82qi1t

--
This mail is sent via contact form on 1Design-Updates http://www.madza-wordpress-premium-themes.com/updates-1design

