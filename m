Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C32690B5
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Sep 2020 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgINPyV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Sep 2020 11:54:21 -0400
Received: from mail-bl2gcc02on2090.outbound.protection.outlook.com ([40.107.89.90]:30465
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgINPuU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Sep 2020 11:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTBhL34I0l25OKnFSgtxQaCHxKwFOO3OMXufFTkP+4WsbmekzjwPIt92DcAzV0ducLY0LpFj1cde7WDh8wKfc7DGjSV8O0EVVHsIsU0WTsXcVpLQJuEiw1irrWSj1SALtYKL7YDTVBfngfBZaomeVgSp7CvkRMxGLbN7waH9Gc0s7/gwgO4D8p9JaXfhol0FWOGIM1z1Lg/QUs9Uoh+Pf1Fhtwdh2iyLLa3dxudxddm8N4QVS/7K036E1gOgvcsu7thdsrucKUNX4ASxlsHFK0dKoZnC+kcsIf8wX+Ji7LShgD8z+u+bNMu6TGg6ymdOGelt+8c48RsGf9eg2vvWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGlMic4nQ4/KNrLotbLNRzunZslZjkEdtmLd2zSVQpI=;
 b=dwelO/yxRwu8iBr9o3ckWh8505w7vC9rlISS025Fj+X/8axlQqZYx6ODSoaorBE9qCKyQQpIqAwwJkmVJ0Uq6QR+AsKEvbe/FEU+YvYylKP3xZqj3ZI7MIPYJSXSMlP9QWu9ij6wP7JI6Lm6++a3qq5b9dRaZIVaCVWg5ZngTGZVaRbboZBD8oLzKrUfwz3XfzPNPyv9IPfhhIYHdHVaRBarw8nHgypDD9q4Y6DRfKE8W3JtTdXstjdBbBIHyrDIXIaf7eVADhTWXwvzx+TTDLIGIutsj57anCL3AfqwfVA92+XA7kWhBmDS58Kl/XM9+CG8nVu/ymPjXnpiXgz+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starlab.io; dmarc=pass action=none header.from=starlab.io;
 dkim=pass header.d=starlab.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGlMic4nQ4/KNrLotbLNRzunZslZjkEdtmLd2zSVQpI=;
 b=D8lhc+0LG5DGSAsOlxbJ5A8jv3KaqIqW+PwgYoYnxOc8vUhBbwb45fkgUp1DF53/mrdAdcOMwlj6zAFrZwL0ZyWLVusrqgqwNC6QUt7gZquQQk1NCFSBqYROXfBb91fcQALu744AUuAsrEA2/YZ1pGVM6dMctUdRmTi47ZKHfT4=
Authentication-Results: starlab.io; dkim=none (message not signed)
 header.d=none;starlab.io; dmarc=none action=none header.from=starlab.io;
Received: from SA9PR09MB5246.namprd09.prod.outlook.com (2603:10b6:806:4b::9)
 by SA0PR09MB6444.namprd09.prod.outlook.com (2603:10b6:806:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 14 Sep
 2020 15:50:16 +0000
Received: from SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::e90f:c1b7:2964:d2ac]) by SA9PR09MB5246.namprd09.prod.outlook.com
 ([fe80::e90f:c1b7:2964:d2ac%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 15:50:16 +0000
From:   Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Mitchell <jeffrey.mitchell@starlab.io>
Subject: [PATCH] nfs: Fix security label length not being reset
Date:   Mon, 14 Sep 2020 10:49:57 -0500
Message-Id: <20200914154958.55451-1-jeffrey.mitchell@starlab.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:20::18) To SA9PR09MB5246.namprd09.prod.outlook.com
 (2603:10b6:806:4b::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jeffrey-work-20 (75.1.70.238) by SA9PR03CA0013.namprd03.prod.outlook.com (2603:10b6:806:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 15:50:16 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [75.1.70.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b6333d-778c-4a25-1e79-08d858c5dff1
X-MS-TrafficTypeDiagnostic: SA0PR09MB6444:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR09MB64446ADC0B4F60D96606DA4DF8230@SA0PR09MB6444.namprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKaD1VVgoqVkgUvSSgC4hSsZ0ymAFlesx1Hj4fHnwD6wVKBRIal2PZPlqDv3nhxQC5+cZYbKVRrroMbDeGnDWmxU0LVWE8IAq1ee5Lys2ZJAYpPAJ4GJZTYv5QNNhDkQHxTY59EWgp1SAspHBulKNib5Md2nhshx1nmmHRnkl97qcDVWN0LX/KfLNDFzQZas8nkYahkoHMBdosDTYSg2V4+XE2+acwCe1gdTMGLxm1wULOFQ4DuOu2ItA1MSaLMVBJE5moq+nBNcSpzXYmWWtX8rOnYDkH2zUxaLbUPwYm/0iEthToZawXbs1WZ9VN4P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA9PR09MB5246.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39830400003)(4744005)(5660300002)(1076003)(66946007)(66556008)(86362001)(83380400001)(66476007)(4326008)(956004)(6666004)(478600001)(316002)(44832011)(2906002)(2616005)(26005)(15650500001)(110136005)(52116002)(36756003)(6496006)(107886003)(8936002)(6486002)(8676002)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vxWSJcOtUqAazZEOhM/2y+zzpvP0PjGgkLSGJ7FEvh7kQflmuxRlfHMWSIeZq46yzyvQ11Fvyvs8ZIFsqMa82qCFhFUblrNaMXu/zDrJNJdyQimBO3806SI+UzO5uJk6p/NTCevAKBms7dWViHFvuQyuzW7acAnQIUtzjhM029ql+eINp6finQi8tuRrcXGrwrlUeg/zT+VerbCfKL2CWkKA5y008/dcPw5N8JBkYGraDt4hFu9NIhelX7HAWdaWWIslCy1VJt4OPk1/nb1qsRN2lHfQpF5uDEcWTDeFjy6wCo84Nj3KsRZ/hRlC2lzVNbM8YsvvqVLWW91SJQG+V++tUfBdCTOTLg7K7OwlRa0G6qr07u/lyKiobTAWOO4nsd6BEh92/1E9YD949XyQvmrf33zah5gzp3JLpVv3hf8JPnT8vbl8wOJP9bQNW0I5lasXJOYo8NLBPgchdXUPFVwW7T7Gdw5K3TjytqMSzwVi1d8IBe1/WTusfMEKauxvflmouyFO1NpFFn5c2iXGLk6AsCLVaoQSM26N+mQzyKL/J1V4qgkqsNk/t7GN0VTqrIFm17Gn7nsqMXTgl5T/Le096DfxDvL/REFg9x+hhyhwQd08XtFQS8Wvs0mFp7rv
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b6333d-778c-4a25-1e79-08d858c5dff1
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5246.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 15:50:16.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzhvmgSc0Kh2pMyYg8w5bmbhQFmCLwzDBH03UF99JKA0PjowpPdV2/vA9psCliTN8hDwFSRyrp6ukU2GVEIa6ruTkMugNea95G1fcAm2iOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB6444
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs_readdir_page_filler() iterates over entries in a directory, reusing
the same security label buffer, but does not reset the buffer's length.
This causes decode_attr_security_label() to return -ERANGE if an entry's
security label is longer than the previous one's. This error, in
nfs4_decode_dirent(), only gets passed up as -EAGAIN, which causes another
failed attempt to copy into the buffer. The second error is ignored and
the remaining entries do not show up in ls, specifically the getdents64()
syscall.

Reproduce by creating multiple files in NFS and giving one of the later
files a longer security label. ls will not see that file nor any that are
added afterwards, though they will exist on the backend.

- Jeffrey

Jeffrey Mitchell (1):
  nfs: Fix security label length not being reset

 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

