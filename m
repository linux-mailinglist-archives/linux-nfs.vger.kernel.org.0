Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9401FF624
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2020 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFRPE7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 18 Jun 2020 11:04:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728769AbgFRPE6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jun 2020 11:04:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IF3DDA130019
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2020 11:04:57 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31r7n7pqtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2020 11:04:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-nfs@vger.kernel.org> from <ntrishal@in.ibm.com>;
        Thu, 18 Jun 2020 15:04:56 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 18 Jun 2020 15:04:53 -0000
Received: from us1a3-mail65.a3.dal09.isc4sb.com ([10.142.3.169])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2020061815045310-606402 ;
          Thu, 18 Jun 2020 15:04:53 +0000 
To:     linux-nfs@vger.kernel.org
Subject: Trunking Support in 4.1
From:   "Trishali Nayar" <ntrishal@in.ibm.com>
Date:   Thu, 18 Jun 2020 20:34:53 +0530
MIME-Version: 1.0
X-KeepSent: 8137F6B8:51CF4CA7-0025858B:00459213;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 10.0.1FP3 August 09, 2019
X-LLNOutbound: False
X-Disclaimed: 49879
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
x-cbid: 20061815-8877-0000-0000-000003CD741F
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415652; ST=0; TS=0; UL=0; ISC=; MB=0.000478
X-IBM-SpamModules-Versions: BY=3.00013309; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01393349; UDB=6.00745733; IPR=6.01175625;
 MB=3.00032610; MTD=3.00000008; XFM=3.00000015; UTC=2020-06-18 15:04:55
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-06-18 09:01:27 - 6.00011497
x-cbparentid: 20061815-8878-0000-0000-0000A247793F
Message-Id: <OF8137F6B8.51CF4CA7-ON0025858B.00459213-6525858B.0052D80D@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_13:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

The 4.1 RFC mentions about two types of trunking: Session trunking and 
Client ID trunking.
 
Are both of these supported by 4.1 servers and clients? 

And are these mandatory features to claim 4.1 support?

Your insights will be really useful.
 
Thanks and regards,
Trishali.

