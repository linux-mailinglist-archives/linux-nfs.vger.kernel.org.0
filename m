Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524447EE589
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 17:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjKPQvH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 11:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQvG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 11:51:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5ABB7;
        Thu, 16 Nov 2023 08:51:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGXq7a012758;
        Thu, 16 Nov 2023 16:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6JzKeXOnCteS5BH4U7Pc7drS9lCY3K5gq+bbpxKDg44=;
 b=DL+B4r9+nt+CV/Jc+JHSliIdIFLPMLMxTnTSiyacQ7PnWAUQg+qlBfaw/euOLXgndhA3
 LC8TlIeSMAtP/PkiKtKvWGqNZ1yAMaHprnvcQIMgHLjdmWXcjxSDbG+p3Ww2OfbBwQyr
 6w7yJTmtHhyqTZAbo21U79rmFt4Grb98KEiLCnvIy034+/rSMIOjqxc6iA9TvS2pZO5q
 zWc8For/vm2nFXBZB5xRwzY8Gtd2GqptqqKX69f4n0RWh/SN80vtZHlesTGm7XXNbwd3
 Akjf9W3KKzGdDDwKzynWS2iV3wEm5X8+45tovymsWxJRo0mPMFLuQz8rUSTT/ofGKm30 Ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qdbe6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:50:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGFOAo038334;
        Thu, 16 Nov 2023 16:50:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq0wbt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY6xlwCSI/XpVPE6X5RvWX++ftbDKkl98BCH6bDQxpTfLdn+5QCxYfMwGjJ1xPWabRjMPNoeM1ocfoF6gNld9a8YaUPqL6EPibo14XDejQkcQM5a9BdarrkiHDk3Q9vHLiiNN7rO708v12xejv4jEdpIN6iXQquQnSS/mMlB5H1fi58CrdZV/VleAr2A7e8w1xrcddslSrCBoxm07EAgFiDbhE948tJ6FiHgxtL2QJYTqDBXu2flmDePnrPU6yvVzaGy9Gi4dK605nMKGSUnveJvkXo4g57kWJgs0VOQdM5gShm8F9AoSYlBWTjl/IPW1YW5HZWRIOpRd4ReFGQXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JzKeXOnCteS5BH4U7Pc7drS9lCY3K5gq+bbpxKDg44=;
 b=nCsNiF4pK9hX5w7AO5pVoBYIuZN+W9vVbMn2c+ntyLC7q1jzv/wp95hN7yqdQ+DxXviRoCsEiQUDC1FUjCdm/EhI297XryfO/vSDXJjVB/6FpdfFbeB5XTlVEFl+89rDlz6ne91eLxn2hPHNUHzIHR2hNcmPLTZLbpXBZyMlDq/55qFZGtI+3mL2rA2IMFwtai49XBEeFjbu2/TMGVDmAE2Jb2jbQAM6I//SISDMA+910aCE90wp9t47fY7VKB+edr5j13CzTqXpDES3VQoDCsltaOXUbsyd1zXfCiKS5uQmelELShITSr3SQiNNghpTIfDSKOl2O7/O7lqRB2elIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JzKeXOnCteS5BH4U7Pc7drS9lCY3K5gq+bbpxKDg44=;
 b=aw+Fg+Z1AiYT8e+Yb4uQKLE+hJdAPIoR3P06z1y4OmLdykYS9KnUbFy4bPhVkiEPZAXWoQJTUibjst5CodW/qqanc1gEiHUQfe9mWKBPCBZKd8Y2dpjko3yceQKUJLYdfvi3t+ssC5H3hm03S06dQ2qrPh/Y3lkQ5YkdwqIGPLY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 16:50:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:50:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: linux-next: Tree for Nov 16 (fs/nfsd/vfs.o)
Thread-Topic: linux-next: Tree for Nov 16 (fs/nfsd/vfs.o)
Thread-Index: AQHaGKy9OFpSbKqVqEi0rRujnmMYTrB9KKiA
Date:   Thu, 16 Nov 2023 16:50:39 +0000
Message-ID: <5DB394C6-8DC5-4F57-97D1-D2F2F4A946C3@oracle.com>
References: <20231116131733.0eae6e6a@canb.auug.org.au>
 <3b0814b2-c41c-4518-9bfc-b1cf676a1faf@infradead.org>
In-Reply-To: <3b0814b2-c41c-4518-9bfc-b1cf676a1faf@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5134:EE_
x-ms-office365-filtering-correlation-id: ca691ea9-8929-433c-15e8-08dbe6c42a23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKy07gnEMnbR++K9AHKs/IeQCPtURPszMuyZLn1M+w9t6MxLxsmWoxQks3rysC6uHttvAtJG9B+rLgMSvVfvOEBLGLVA+r2yqGH4QtelGZAzBypSRysxhnuv1wenBysxkyjjVnQu/KElr5OW/SF9Ow+O4dBiQSJFKzeJq/HMQJfu8u2vB1Q8yTgKBEW7ncX1xE8TBo99UCLej7xy/cLFBpBWOohhG2k7GHaoxI5W9Bi+aHGF19h1IhhvN/DTM/TdT0vVJHQOB0zfCZvyjc0JWCtyRJsovmw6KXDPTNZafdAdz5Y689m+leSXkVzZDu3cRWA3nJvUupqyx7eh1KGwSHfQ+aV3WAodaWrgEYFbG1vmi7kZ/gy0DxbDKeyIyd8q0gt0/lzr0ne4y9RJrjlGqQXsL9YZJRDlFEQHyy8Ngp6b5UqxBTfpWpKIT24ql6uu/tvG2N9j0mIKfssH++Mrw4fnfhbAXGVasjIH9M4C12Og/E79HRUgQJ3ZdLNjkAeKGkYOfW8nV1p2crY3COsLPzKIRovb8GdUQt1jprknpasOb9hAVRKnctCAYVN/kdjdz7bbta5yLzEEBy0N7SGkOUB+zMFxtQ4v1NwYRe8QxdTXDHuurciIVgjZFhdR8vOs46HtWEY8lFPdD6e79jiZ0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(122000001)(2906002)(38100700002)(4744005)(86362001)(5660300002)(4326008)(8936002)(41300700001)(8676002)(33656002)(2616005)(36756003)(64756008)(6916009)(54906003)(316002)(6512007)(26005)(66556008)(66446008)(66476007)(66946007)(76116006)(91956017)(53546011)(71200400001)(478600001)(6506007)(6486002)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjI4ckwyVmM0a21VUEFYWnZWSDJiajNjNjZrbUxWZjRZb1lOUzREbVZiUDV3?=
 =?utf-8?B?eWYwQkx1cC85b0hPWTNnckppS0w4Tm5BZmxwOXZqZXkycXY4Y3puNEw0U1RP?=
 =?utf-8?B?YzBzMURteUpXcXBiZ2JZWjYwZjVIM0VoQ2dzMnh3LzNrSHBxZC8vZHhFU0dm?=
 =?utf-8?B?YmRPZEJvSExRaTlNWlJ6QzYrcGN3eGxmTzRXS2lLd3N0dDY2ajFRWkRWeWpG?=
 =?utf-8?B?citITW9zMC96b0c5bXNTRDZGKzdjOW9uSzhnZlpOS0FHUVA4aUluR0VpdU5k?=
 =?utf-8?B?TEQwdldET1BIL1lPNjBMLzJ6bzRoUS9KRVJzK3JGUEZZNGF0bmt1UlowLzF3?=
 =?utf-8?B?NXNJOUowSFFyVFM3RllpZmxCTk1VTUNHdWh2YmRDRXJvZXp2NS9zRC9IMnNJ?=
 =?utf-8?B?bWh4RW4xS1VkbXFyYmZyTTJvL2wxakozMXBmS1ZyTFZtdWN6bXJNVFhSU3NL?=
 =?utf-8?B?eU1yK0ZNdk1FUXlFK1cwRkV5MEtKVlB1dWhnc04rRVZ3UnBVekxhMG5mNWd2?=
 =?utf-8?B?V24zQ0M0WmdlR0pZS1pFODBRbCttL3F5ME0xNkZ0ZWtlRmNndFE3S1IrODJq?=
 =?utf-8?B?bWV6emFSWnJkNHVNbjVCV2xDamM0QldzZ3YrU2ROU1BJY0lSZXdMSEo0RTg4?=
 =?utf-8?B?Y0Y5clRCSVFYN0E1ejhLQ1AvVmlCUDlVUVNRK245M1d1Q0VPNVVxeW5IOTZm?=
 =?utf-8?B?QjlWN2x6RnhLOXZ6MmwrRVpFWUNnMmY4VVFaeXhhNzBoTU45VytuRVFGdWVl?=
 =?utf-8?B?bWtkcG5WVkxTcDFpaUVRNGV3Y0NuOHloUWZoTUs4dTE4aVAvZXpyWk81QUJ3?=
 =?utf-8?B?UDhKcHora1JIWnlqQ3QrVGRjbTJ0NnpiK0dJdGZOeHAzOEo1dmo1Q005Lzhu?=
 =?utf-8?B?MFJSZ2lCRTh4Z1JPV3VFSVFkMWFiczlJQndUT3ovSmlweitXRUNWdWdtL21Q?=
 =?utf-8?B?Q3hzOUx3cGIrZ3I5WGRTK1lvUkYyazhQR2E4cDlmSm5YSDVQNzgvVzg3OE5v?=
 =?utf-8?B?NklPbnpTa1QzUnVRUUtlL01kRDUvaGNWVmZZZ2QvdkVkZFRpc3M5eXlsRDBN?=
 =?utf-8?B?ZHUrZXN4UWtuNmxvTnVSOVJiWVphMUptYi9KdC9lSWl4TlMySUdrVTEzT20v?=
 =?utf-8?B?VlNkOWhqNVJoZjJBUW9mRW1LR2ZGWVc0V2J6QjB3UHdzS2g5Q1JBbThzdXZR?=
 =?utf-8?B?OXE2MHNYczNjeHpJTFdiTXQyaUhBWmVqZXArTTRtQzl3VTg4c0dYdzR2dTFs?=
 =?utf-8?B?Q2ltWk1NcVVoQ2xJSVRDeU9mQW56ZlFtcnBnWUdUQXRDTzg4MzJoZVA5Y3E1?=
 =?utf-8?B?UTloa3ljRmJlVjYzSEU0MnpFUmpBNkpJbTR4U1JTMjd3TEFmYzBNVU03K2RL?=
 =?utf-8?B?Z1M1RmdTWi9ybStqaSt0eWhYZEdkS3lsNFlRYkNMY0JLZzJVOGtEUnNNeVFQ?=
 =?utf-8?B?bDJoWW0yM1UvYlQ2UmtEd244T0hEVEtsdUh6NlY2ZUo0Zlc0Smo1UzgvSUNS?=
 =?utf-8?B?azltanB2bU9zTU1ubzM2V0R1bzVMWkt4ODVaWUM5Q2hSNHp6a2YwLzQxTmVZ?=
 =?utf-8?B?Rnh3dmdnNSttcU1sN01iVVVQTHpuSlRncGdoekh5ZkFlR25WY1RiMzZDYy85?=
 =?utf-8?B?OGM5RmZiazhpWVB4NWo5TXdJckFMMFREMExRMmx4Sk5IWkJSbUVldE9aQmZV?=
 =?utf-8?B?bmptSkgxRzM4QUh6WjNOQ2lpZHNxL25BQ2wrRXdXTy85cndwZVJMdGNnNkhF?=
 =?utf-8?B?S0hxMnZLUldzamVkUjNqS2dEdjF5eTllOGp2N1BZQW5iVG9KOW1hTDl0WElV?=
 =?utf-8?B?U0J6Z2ZnUytKSDFTWk9uRXVSSkZsaG9mdWd0ODQvUk9PbUt6NFYzUDJxL0xC?=
 =?utf-8?B?YXkxSklla0NzNmF4VmpmNHpJV0JuMHJUWUxJMTRCKzNqazRPUS9RWWNscmVm?=
 =?utf-8?B?RzdwK2tka3dHSWNvMDhERFEram13UUhVcTNFcmhkcWg5MmtpVlFDdm54bGtJ?=
 =?utf-8?B?OGp1b0g5YnlFR0FwZS9QZkNQRnpoT3JKcEE4M1VrOVpEOFVTWFIwQ3pDc3Jl?=
 =?utf-8?B?T0VPOCt1aEdTRjdoUDUrTENsQzBST05aUnhITEhHamx6ZGZSSVVObUZaZ0pC?=
 =?utf-8?B?Qm5MTDdEQW5oVmMyVTF4cTQwZ2NjTGRlK3JnWVNpeFNlSHdEc3VXTk91V2xs?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD56F47DCBF7D449A45BAC544D5768D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wKCAeOP1ZHn380U+X4NnZb9KKNYJjPc7sAg2J7eqTnfueGugQ801iastSmCMO9DEoA7PQ6HmU5GpSK0Sz5twk7UktGyizC4NfC3dVZNVghI61mOTa9FdRR4DKv/Atv3wTH0hsa2+G8wIvy4gP5baz5813xHlCkYGxxVmM2PQyZv0NzYuCHfi4Xu3USnLMmy4oMWhmRm6rzUR/gDWp/lme+sNOoSOTslNgn1Dtw6RGAMkEbduM8yhT2lY090NddlXo4OEb+av4nx5U2EY6fdbsWBzclWVAM+BJFTonVGMFE81DFpIhOpCTDEFI/M8xHdGrhtlJJWSxe1Ij9u3kpZZkJHYZCNEpoc3Hthc9bNUp96eosXHR871NuP8v2LaF3jblyy89NtbUwGfCGl+PLbSSszNFwDFs+HTkuwCvcdT+mCDBcIeDUGEKwjspK5WQ2zValNheZGc5inPyKBl8aaoPR6s60FIwNDREJz+zg34q5YLQNF2zxYbWu+yjBH0N+bKs468HHEpFv656X3qrGV9vVcsDt03KBWbKH7Qkrf8xglYgusSgrSVbPVseP6yiWFRX1mcuJ5N7Mc3ZzVqZ/djCCc1Lj7hG86zhNyISuBjV9Zqkxvn/1F6JTKRmHhWNH9OY2TKCgBQfNjLPKUXQ9Wj5wjhIO9hICD1qy5UVpOFZKAsQn9m9gWXk/AdidbVIEiGfTT6CHsoJp4eYUiq4iHSEV/QOaE+C5w3L/4EHU4KRilPisrKsXX3lwzNy0mveQ4YoKg/GECpu5f0XdLN+d/BqWNoHrOEJJXLvCYW/UM+4/GtsthBqFniWJgWt3z7kuO9ba7BRY0VJ8IYG+uJGqTXz3M2soV2MKo5SalMhTefeqWPX80DTCpvmKEReO+m4YTT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca691ea9-8929-433c-15e8-08dbe6c42a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 16:50:39.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8+Jd+kwr+amYMWVbWmtEmZESzvHrCXgLG3lmiVtU0nDYhQcoJ4b80yn1T01SBE7Q31owUnkmVZ9LO5ZRPq6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_17,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160132
X-Proofpoint-ORIG-GUID: Ffa43cQ6CfQv2vR9mUn1IbSJD0Dd9E5a
X-Proofpoint-GUID: Ffa43cQ6CfQv2vR9mUn1IbSJD0Dd9E5a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE2LCAyMDIzLCBhdCAxMTo0OOKAr0FNLCBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDExLzE1LzIzIDE4OjE3
LCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3RlOg0KPj4gSGkgYWxsLA0KPj4gDQo+PiBDaGFuZ2VzIHNp
bmNlIDIwMjMxMTE1Og0KPj4gDQo+IA0KPiBvbiByaXNjdiAzMi1iaXQgKHVzaW5nIGdjYyAxMy4y
LjAgZnJvbSBrZXJuZWwub3JnKToNCj4gDQo+IHJpc2N2MzItbGludXgtbGQ6IGZzL25mc2QvdmZz
Lm86IGluIGZ1bmN0aW9uIGAuTDQxMic6DQo+IHZmcy5jOigudGV4dC5uZnNkX3JlYWQrMHhmOCk6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHN2Y2F1dGhfZ3NzX2ZsYXZvcicNCj4gDQo+IA0KPiBG
dWxsIHJhbmRjb25maWcgZmlsZSBpcyBhdHRhY2hlZC4NCg0KSSByZWNlaXZlZCBhIDAtZGF5IHJl
cG9ydCBlYXJsaWVyIHRvZGF5LiBUaG9zZSBwYXRjaGVzIGhhdmUgYmVlbg0KZHJvcHBlZCBmcm9t
IG5mc2QtbmV4dCB1bnRpbCBJIGNhbiBhZmZlY3QgYSBmaXguDQoNCg0KLS0NCkNodWNrIExldmVy
DQoNCg0K
