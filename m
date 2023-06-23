Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792B73B981
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jun 2023 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFWOLY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFWOLX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 10:11:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36782688;
        Fri, 23 Jun 2023 07:11:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NCFIp3012715;
        Fri, 23 Jun 2023 14:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TMYV+/h5OppZnBHMTU4tOgImO2bSVfpRYweA5LTj0ds=;
 b=u3NoJ/yngG1qqbtgnScC6lGEE7bK6twf5LqBH2sq9mMt/L0XaX1r0HYVcNxhg23Efp4K
 Sw6cJXzOcbwrE67YK2bms2irDRlQB3b5FG1Hz8T44JJd1q4Igegp3+7dRcJNDTcFDrUh
 OeqUBpVaMw6tdpPNOKMnM9MFEpmnDFCKieWSHG0LcLkg6Khcz1bWb2wJ+t9biwuT3qAB
 zzqs+W1lQO1luuY+1h9ElEW0Obl376HPNO4SmTrB/0GQ9JRexQPhy7wIZQ3nlGV6czpD
 kDMfGGeKnfrqScgugYxetxnJRiXB++o3kYeOZCg/qaEQ2z2Uvo185DZw67PLysY7EKJT yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3v6ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:11:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDGSsI008390;
        Fri, 23 Jun 2023 14:11:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9399dkwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYAm2LEIP+BeHmaf56CI3BFut+cBi6WYEKGBqDnqpHNT7XhBSXSufkDvr+lljJ9dTvK0ceCowwE0eckeRLVZNXH/QArWUB3z9OkRdpsF0FYJYOIqfdRVoqHfexIA0B0HcDqUY3PxxKZ2ywWGSOymO1j/eJQDHitCjhz9CGMsaPN+2Lh1UBX7UG/3X3M9FX0pPm5OEry7cn0ismhm2TVwcxy7SFI2ofp7A9yDUhdCbxBlXrEov7HQMueotYb9i1qqvaGdGfPgbUhhO+RPArncKmJa5iNzjncUmh0WHbQ+AOoS3iB6yaRy15i8P/yq6xbjdftsRPYbU0kvscH4g5dB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMYV+/h5OppZnBHMTU4tOgImO2bSVfpRYweA5LTj0ds=;
 b=oLfmEvp4JPo9Nalxiu8ucMXFks/yCZ5g9CMTYgK8aSTBGrymFYcK45TgRyyDTySSQTU8Thbi6HPiJz00aWrpL3bukbZhmYvhMe+5tCpvoDAEG9Qmg5t/LmSxbGP/Q/HBJQdvrdebvpcCBYgJWy9VbMiALGgkH2lSS3+rOygYTenhjl5vAKy3AofTuCO/3/vMH5EBTLgq3lmXy6ovEKdjAWVrP1IvK+3DDlZuQTsLMB2VtQfXikAiTGa8nKFCHU4s8vusyvLgFrNPKPnCXY/IyBOeUAxcvmevdlG8EUp3r7yqX/l3dBhqBujQLxcPYJUVclKAj5VJlrFpXXjiRkW3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMYV+/h5OppZnBHMTU4tOgImO2bSVfpRYweA5LTj0ds=;
 b=BFmA/v+0Y3IjnuxVSsUQYbhZQNO2A+mBRjs2vW3Ympt6hhevTwpcXzFSD2AKejg8koLdtTlhC4XUa4hOMzPy9zplrajI6eEja4H7v4g6X2oQii5QZx2iEPmRDrzTa5h6UgwTMB6uTFHZGgGbQhEcdgaAQevXKObZXc+Qnk5k8F4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 14:11:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:11:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: [GIT PULL] nfsd changes for v6.5
Thread-Topic: [GIT PULL] nfsd changes for v6.5
Thread-Index: AQHZpdySInuxw96uxk2xfT0DDyUncA==
Date:   Fri, 23 Jun 2023 14:11:14 +0000
Message-ID: <7849B3C2-CE1C-4C52-9CAE-23CC7FF42A41@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5750:EE_
x-ms-office365-filtering-correlation-id: 2d575c8c-88ce-460a-1e0b-08db73f3b4b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bp8gbMLgr+3Y+exOiuue3kCfep0/NyGSYnAdnvcKGlkv+BJ//drL5HonUz3UK1ZO27H2fW8bxoxnQUh01FJQRcnz4nO+oRNbWxbf6oxq7hYBBsCe/zAKq37dtUCR2h0cR+j5SVwxPHNuvNWJqEHrWaEg16uM5kaYIPFJPO5oCDkgOG3SUO2WfXHbUcnFcnSgz7WQdfkH440c9x5jRsSv39z3hGYLSO5LGA5zpB9TWToydm0BetqKEcOKNSMv2tX1kFecGJXkYi2BE9IXoND7qN0nWM0dv2b64f7KXIQ4WQB7ix98XBXf69M4XSUFThNRdw61uM69MFslfyIK46WSKchBmylSeGBZY2vzsC2DtkNZ0+cgeSDO2oljU6tDD9cKP4fmDVajoUot1XIFagITOcRrX504fL+CGTBuwGQHxCCAkr9FDXrU5rS6S9g1gpLSKQS1FyqMBlpDPO+/K+/lVmO9wMVnOd7L+1wslSSfYVB0kq2g5e5lkHN3FDAevKGrQExHt+oX0zShj4cXyIqvt+D4hO1QKtbcjWRpwOSQjrmspyKLQ58WCWvthR23opZhEJoJs+sbRjA8jYtF5qP/6lGhM3P2vW8Ntixy42TXAR8h+/V1NuEBhkvQ9BolL9ERgTMp03AWiD043CxkAJ2O8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(66946007)(4326008)(66476007)(91956017)(76116006)(6916009)(66556008)(64756008)(33656002)(8936002)(8676002)(66446008)(478600001)(36756003)(316002)(5660300002)(966005)(54906003)(41300700001)(86362001)(38070700005)(6486002)(2906002)(186003)(6512007)(6506007)(26005)(71200400001)(38100700002)(2616005)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pfPj5U9m9R3Bvrk8P9VgnJ2HYGS8D5Dd4FaPTBYYJMq+EGkX8DbDKa4Sz3J1?=
 =?us-ascii?Q?iVZSjpMThEaYWmYr5Jokc4Ebz/ki6t0HW3Ld21sBoPm+3ig0d9FEvV9b/E/0?=
 =?us-ascii?Q?UZKaTvvwqekum66INAPuImJrepqpc9EFE8s6ACrRG7k0L3kuFWEWeWpPfluL?=
 =?us-ascii?Q?+/rXJFU3u8h6dXZE26o+hb6ioieP9qFTtI6Epmz1Xab5eEEKdgTEh4q1UW9T?=
 =?us-ascii?Q?NDJpKBIQcOXEhiRWVOWY3mYTnz+Wmcsu1UfqTcLrfcUycIWsiFz7CszU3RN1?=
 =?us-ascii?Q?IS3rwUULDm9gDDE8A2g1q8vLDOw6Tlq9RtCWCTnG+98bQHy+QylixV8sBEis?=
 =?us-ascii?Q?9xBskOHPsTT1eXZlv/gM4UyO+XGe29mZJaiuvaHFbcCEZ6OJ22NR6b+9MBam?=
 =?us-ascii?Q?NUb6Wpg4lVCwfT7DEIgMh28xjIaKNEezhJoTgpEEoCdT35F2s+xMG7AaDfFR?=
 =?us-ascii?Q?/3nnFePXJJGwM/hxiUrh3V9YpLjoOeOC9F457M3mRfKeXI9SrscpHt2jO64T?=
 =?us-ascii?Q?y0SKvSMjEMUXlXgHSThIKKNONnLIqi/IuZNlGRUrioS6BV+mhmSUmK3Poen2?=
 =?us-ascii?Q?Lk4z79SPEXCffSQ8Su25NEIWDcrXrhJfH38kQpEYWjJ3USwWC403Cp5HVRTJ?=
 =?us-ascii?Q?8L7r6Zwad+4zPRIOeo7Jm0uLf0wUH5KtNMEj+S2RG2l6Nww82uED4LY5hnpa?=
 =?us-ascii?Q?xfIk4tZ5iHdXJcdQJY44TemRb3qDRgI1t9aXnwDV5x9AxHzMhCn3nUfAmVw/?=
 =?us-ascii?Q?J4UUXvEGSQvjquzr/uJoWothP0tm8bilQNeObOeamCjM4CbCbSokfM7ntLbI?=
 =?us-ascii?Q?tiG6KdA+QeW+jfwSzPD9glLpXZLYkZYiijnuAd+lV/ta1lmJulJJNcjK3U18?=
 =?us-ascii?Q?lejZkhqfzUR0aUJjTxpyaGsO/FnCq7psAjzzbrIFaN1XmMmMOW0+4VCBpApC?=
 =?us-ascii?Q?/bj8OiMkj5BEr1G8ORm8dTP2+7aw/4aGSc8XNIyNEp+X/lyMlSBN4kY2vWNh?=
 =?us-ascii?Q?uB6kG8r9OFvTpcnQm4TPb3zmQiyJQLLjHy0Q6RuxMde4Zw4G1ibL2DT7LBfQ?=
 =?us-ascii?Q?g3hzGKyST0Ghg/QkP1O0MkvxUZXS8e4qA5vFi9xA0Ae0jzrE8bhkL353fvID?=
 =?us-ascii?Q?clnXBalF4O4OUToookXtuynlDrcrC3lsuVejj4kx6PG063MJEmctuCwcOP+U?=
 =?us-ascii?Q?17NAbgpt9ebYhOqwmd87FOpJ3Mrk3sCyeMwlGXq3xBKUDOuyUdgNdVPZmMAK?=
 =?us-ascii?Q?u4PusTrPsizkV7Xk04crZJgKRf/2AyZFevylYBkYhvcJiFiXk1t6yrsE/jBX?=
 =?us-ascii?Q?kIiHaMHuQkx45WGA50CF99WtqfbaJBs+VQPDglrfpCsNWEyxdTidsOk5/EBI?=
 =?us-ascii?Q?vvQhM14N9Cqdj/bvXWzaZOOda1GFxZ7OzIVQtSLe/aMmOH7Am0uOlmqkhLQ2?=
 =?us-ascii?Q?rmcTXLdDlwB2FHWJhDul8YFkJECLQtsSuj87XI57+eTDsTPdlJjvu5/xSzSE?=
 =?us-ascii?Q?Bp2IOcIySbD4vUt5CP5lb2zpyefvLb1qp08xR9GqrKg2w1I2qgEUFULv0KJ6?=
 =?us-ascii?Q?/ImUatC0DSB80OosNKdDGTojTcyI/7iN2CI8KKFiIn8yg2PFx+e1eHxDCWBZ?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A05362B71CAC644FBE1AD766C682FD7C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9V1Fb/swyjROG784ngXFSOJgzwBf6nmeMU4YEUp4mJZZqAJH+11vub34RCmEkhu8ZvyNkTm6dQ8fcfAr7SePSU3bFjBvCLmTvIWPNSlTR8r0w6r9o2aYrORw40PhkKtaEcdPudutM3kuCFjYlh69PKNl757BGQPQ8PGW+mzNbD8fgGOidetmJDAPKsK1WM2k7y5u+miirbdIQBrnpNCyXMr3mOuEIvmDAnktO76COfHY4ETQ4jsKiBALYZprq6DV7R6g++F6Fv9ChWoUqYD3SUdcIpIrRLlGCfAo+kldK5NjBeFh7FRVAqgIAqWHtFWQdnyM/geT/xS7Y8ediXgdFmlYCGaJJ6/JRbwr4GVbwf+o5Mhzac5G1C1IZa+KLBN8mSIwG7N3rPmF6y0ProcqBrexWfG1uC2iGjoQgFT6ZYn2LnfYFHwrjyzoYZthk1BGj8R+0eM7wZLeJakUouOY8qvQB/BKbvlUxBbc6vxnyMXzCoVSMdZTUNJRiCJ/dxwIqiV88D1lv4tcXL9/3T0ImTC2oCLPKbpvuMXltkB0UTXAtd55qpbX1e/hRIOY7didnNnwHFnxIOYKHiuHUs531CFBaAPVWtOLs6kvJcKq/SrKmrAVcFqRRb1640pG69CvOdJzdkANqgt8xrTb13AqKT7SubcAc38npg/zZCM/NTu5UYc26kzFj3bst537DU7lu/j7fKEsRWzO5gfWsN6Ia6UvuABnNEyPj8Cx9I4Jn1vsn/NOcEHDXX+1GUOXvVaJt18fJSc8nYWER9fFmN090EjtXbb58H8IkIP9IdqRxMiOua3cMxvr8YvOK/+ftRE0isEKB3CkkJt5J/HF9heO1u1hXEcDwnkMCOUFAyZyIk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d575c8c-88ce-460a-1e0b-08db73f3b4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 14:11:14.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxuPkqHVZUXhlA4K0fhCfx0SgSKKLdqAb4BY69+oIiNv2MPV497AfYXKNDKoV2z63h9qgNhKnd0T3aH04RSSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230129
X-Proofpoint-GUID: sHqi_Mrb0UzBiQ9PgcJzEB_2GsrGK27B
X-Proofpoint-ORIG-GUID: sHqi_Mrb0UzBiQ9PgcJzEB_2GsrGK27B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

Assuming you will open the v6.5 merge window on Sunday, here is an early
pull request for NFSD. Most of these have been soaking in linux-next for
quite some time.

There are no major features this time. There are a few big ticket items
in the pipeline, however. I expect some interesting stuff to show up in
the v6.6 time frame.


The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7=
:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.5

for you to fetch changes up to 75bfb70457a4c4c9f0095e39885382fc5049c5ce:

  nfsd: remove redundant assignments to variable len (2023-06-21 15:05:32 -=
0400)

----------------------------------------------------------------
NFSD 6.5 Release Notes

Fixes and clean-ups include:
- Clean-ups in the READ path in anticipation of MSG_SPLICE_PAGES
- Better NUMA awareness when allocating pages and other objects
- A number of minor clean-ups to XDR encoding
- Elimination of a race when accepting a TCP socket
- Numerous observability enhancements

----------------------------------------------------------------
Azeem Shaikh (1):
      SUNRPC: Use sysfs_emit in place of strlcpy/sprintf

Christian Brauner (1):
      nfsd: use vfs setgid helper

Chuck Lever (38):
      SUNRPC: Fix an incorrect comment
      SUNRPC: Remove dprintk() in svc_handle_xprt()
      SUNRPC: Improve observability in svc_tcp_accept()
      SUNRPC: Trace struct svc_sock lifetime events
      NFSD: Clean up nfsctl white-space damage
      NFSD: Clean up nfsctl_transaction_write()
      NFSD: trace nfsctl operations
      SUNRPC: Resupply rq_pages from node-local memory
      SUNRPC: Use __alloc_bulk_pages() in svc_init_buffer()
      NFSD: Add encoders for NFSv4 clientids and verifiers
      NFSD: Replace encode_cinfo()
      NFSD: Ensure that xdr_write_pages updates rq_next_page
      NFSD: Use svcxdr_encode_opaque_pages() in nfsd4_encode_splice_read()
      NFSD: Update rq_next_page between COMPOUND operations
      NFSD: Hoist rq_vec preparation into nfsd_read()
      NFSD: Hoist rq_vec preparation into nfsd_read() [step two]
      NFSD: Remove nfsd_readv()
      svcrdma: Allocate new transports on device's NUMA node
      svcrdma: Clean up allocation of svc_rdma_recv_ctxt
      svcrdma: Clean up allocation of svc_rdma_send_ctxt
      svcrdma: Clean up allocation of svc_rdma_rw_ctxt
      mailmap: Add Bruce Fields' latest e-mail addresses
      NFSD: Add "official" reviewers for this subsystem
      SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain the page backing rq_res=
.head[0].iov_base")
      SUNRPC: Revert 579900670ac7 ("svcrdma: Remove unused sc_pages field")
      svcrdma: Revert 2a1e4f21d841 ("svcrdma: Normalize Send page handling"=
)
      svcrdma: Prevent page release when nothing was received
      SUNRPC: Optimize page release in svc_rdma_sendto()
      SUNRPC: Move initialization of rq_stime
      NFSD: Add an nfsd4_encode_nfstime4() helper
      svcrdma: Convert "might sleep" comment into a code annotation
      svcrdma: trace cc_release calls
      svcrdma: Remove an unused argument from __svc_rdma_put_rw_ctxt()
      SUNRPC: Fix comments for transport class registration
      SUNRPC: Remove transport class dprintk call sites
      SUNRPC: Address RCU warning in net/sunrpc/svc.c
      NFSD: Distinguish per-net namespace initialization
      svcrdma: Fix stale comment

Colin Ian King (1):
      nfsd: remove redundant assignments to variable len

Dai Ngo (1):
      NFSD: add encoding of op_recall flag for write delegation

Ding Hui (1):
      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Jeff Layton (2):
      nfsd: don't provide pre/post-op attrs if fh_getattr fails
      nfsd: move init of percpu reply_cache_stats counters back to nfsd_ini=
t_net

NeilBrown (1):
      lockd: drop inappropriate svc_get() from locked_get()

 .mailmap                                   |   2 +
 MAINTAINERS                                |   4 ++
 fs/lockd/svc.c                             |   1 -
 fs/nfsd/cache.h                            |   2 +
 fs/nfsd/export.c                           |  12 ++--
 fs/nfsd/nfs3proc.c                         |  14 +----
 fs/nfsd/nfs3xdr.c                          |  11 ++--
 fs/nfsd/nfs4xdr.c                          | 289 +++++++++++++++++++++++++=
+++++++++++++++++++-------------------------------------------------
 fs/nfsd/nfscache.c                         |  25 ++++----
 fs/nfsd/nfsctl.c                           | 116 ++++++++++++++++++++++++-=
------------
 fs/nfsd/nfsfh.c                            |  26 +++------
 fs/nfsd/nfsproc.c                          |  14 +----
 fs/nfsd/nfssvc.c                           |   5 ++
 fs/nfsd/nfsxdr.c                           |  11 ++--
 fs/nfsd/trace.h                            | 259 +++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c                              |  80 +++++++++++++++++++++----=
-
 fs/nfsd/vfs.h                              |   9 ++-
 include/linux/sunrpc/svc.h                 |  21 +++++++
 include/linux/sunrpc/svc_rdma.h            |   5 +-
 include/linux/sunrpc/xdr.h                 |   3 +-
 include/trace/events/rpcrdma.h             |   8 +++
 include/trace/events/sunrpc.h              |  41 +++++++++-----
 net/sunrpc/svc.c                           |  41 ++++++--------
 net/sunrpc/svc_xprt.c                      |  26 ++++++---
 net/sunrpc/svcsock.c                       |  38 ++++++-------
 net/sunrpc/xdr.c                           |  26 ++++-----
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   8 +--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  36 +++++-------
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  24 ++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  62 ++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  18 +++---
 31 files changed, 802 insertions(+), 435 deletions(-)
--
Chuck Lever


