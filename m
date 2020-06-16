Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6203C1FB370
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2020 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgFPOGA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 16 Jun 2020 10:06:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728644AbgFPOGA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jun 2020 10:06:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GE1bGZ153586
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2020 10:05:59 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31pssrbyx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2020 10:05:59 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-nfs@vger.kernel.org> from <ntrishal@in.ibm.com>;
        Tue, 16 Jun 2020 14:05:59 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 16 Jun 2020 14:05:57 -0000
Received: from us1a3-mail65.a3.dal09.isc4sb.com ([10.142.3.169])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2020061614055690-572010 ;
          Tue, 16 Jun 2020 14:05:56 +0000 
To:     linux-nfs@vger.kernel.org
Subject: ACL's on 4.1
From:   "Trishali Nayar" <ntrishal@in.ibm.com>
Date:   Tue, 16 Jun 2020 19:35:55 +0530
MIME-Version: 1.0
X-KeepSent: 7A07A04B:B2FBC2B0-00258589:004D5BD3;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 10.0.1FP3 August 09, 2019
X-LLNOutbound: False
X-Disclaimed: 32519
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
x-cbid: 20061614-8889-0000-0000-000002EC48AF
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415652; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00013297; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01392370; UDB=6.00745152; IPR=6.01174648;
 MB=3.00032579; MTD=3.00000008; XFM=3.00000015; UTC=2020-06-16 14:05:58
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-06-16 06:14:43 - 6.00011489
x-cbparentid: 20061614-8890-0000-0000-000066984B97
Message-Id: <OF7A07A04B.B2FBC2B0-ON00258589.004D5BD3-65258589.004D7269@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Looking at the 4.1 RFC, there are some additional 'Access_mask' and 
'Ace-flag' when compared to 4.0.
 
- Access_mask:
ACE4_WRITE_RETENTION
ACE4_WRITE_RETENTION_HOLD

- Ace-flag :
ACE4_INHERITED_ACE
 
But are these supported by 4.1 clients and servers? If you do 'man 
nfs4_acl' it does not seem to show these additional ones. So how do we 
set/get them?

Also, are there any other differences from an ACL perspective between 4.0 
and 4.1?
 
Your insights will be really useful.
 
Thanks and regards,
Trishali.

