Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E05317C0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiEWThq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiEWThg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 15:37:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631113B8C5;
        Mon, 23 May 2022 12:25:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHXLDJ016393;
        Mon, 23 May 2022 19:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=20ZGj/Xi4/EHUmgCgMUSEJDdecjt9pohYodI5V5D82A=;
 b=DisG+YLH7lWzEQpY/vK4QwgLj2Wt5+H3Ry5ih9fxLVeVF2g1MnLHPFgiwZfNyCH61PPO
 4Spf056aC13uPPXMbslVlE2TSL7QUDqGiuKG5KwHkbhkeW/EuPkMBUvDUMqlIISR6vcW
 eH54F4XYu9c/pHD95o3bvgIELecuHra1dxFA/UPfhd4ysiFIJcHqQ3sQGbeIOsrP7tTo
 4zj9HXix/m61XESIztVFWG+F1WuQg8pvEgT0Z7f44yjzgSIW1m/jgXz6uoU+y6Fcl5sa
 9E3GTc46iJxbg30EKRqOhMgQDipy3Pey2mPL2r8Sqes/z3NH49o/kJjc/aPdvw0u2JfN vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya497x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:25:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NJG5H5009809;
        Mon, 23 May 2022 19:25:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1xrrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/jMM4kGj75prlfmrjLq8cDJzIHuOHj0LsL+XdKJzAH1zyechLUae7uH92hPyH2O4xBEHFJj//jEJUMEdEj7oEsnNxKkGrlAr4emZoyIQxspO9TC2gV3iBUaJaBbpEHWDLtpvokZ3bWIFc0Vb60ooapTsjxrhAiHsvXGD898F+TUZSWxGFrM0Q7qZCorn4esAznKDA2RoxduAz8Y+ckfD6kGJwyle3gVUInex1apE3moyx0eJhdSVzYR7acowhC2dDE8JyRB3Rs0hlERUacz+gu9oY7tSC+ZYIXoI5i7e30Y9sRj+pWGUu/lM04W1c0hGy1P0JNLvIStgVLetln8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20ZGj/Xi4/EHUmgCgMUSEJDdecjt9pohYodI5V5D82A=;
 b=mppHTjf15UrymCcPmcJtlsTpoTSEgncOVwF5Omq7ixHNtN0UFq/2jpFSg1FQWWz8My1EuUac4sZt0HIJNfW0N40KhKb1vBc/Rw2vx2Rsum22iaI/EIQJny4iRVfKj/GClpRf8IPXcAl3t58lB/AWC6UDftIQ+EJ3wjBlp+0GRC98K1C0MDIQUxMb6aHkj8m98NOxP5jY+Lh+sxsipiFfiAGQCE51q7t/Dv5iTwecldVtjLu3X17vpbscUkaXQfBd3KpfnuSc8JlcZ+ZwpoTI/CJaIk7umK0hg3r5+fxGO8Um5C5bkgEWUYSGXe6hQDG5QDsOVTwEfn20LjHBKGqiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20ZGj/Xi4/EHUmgCgMUSEJDdecjt9pohYodI5V5D82A=;
 b=aUpw0+9WeCpZDBhLqoNMhuAQUMAb/WuFcDUsMYyYIF0tlcJdtVPTQtDlphYny41IcZlP3KPKlCMAYlIGndXe7atFTz0qieabENgtE5vj2Awdmkm0NQJ3aH4Co0Ea6EoxeQMtjQXfNmB9Nk90oLMblG6IeRwtzTuH88+mZNtC+10=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 19:25:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 19:25:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Julian Schroeder 
        <jumaco@dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com>
CC:     Amir Goldstein <amir73il@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "benh@amazon.com" <benh@amazon.com>,
        "alisaidi@amazon.com" <alisaidi@amazon.com>,
        "jumaco@amazon.com" <jumaco@amazon.com>
Subject: Re: [PATCH] nfsd: destroy percpu stats counters after reply cache
 shutdown
Thread-Topic: [PATCH] nfsd: destroy percpu stats counters after reply cache
 shutdown
Thread-Index: AQHYbtZPfPOr39v3Ck6/rr8AZ3u7860s2AsA
Date:   Mon, 23 May 2022 19:25:29 +0000
Message-ID: <BF85B60C-EC88-4514-AD3D-93BBBF3A4A9D@oracle.com>
References: <20220523185226.7614-1-jumaco@dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com>
In-Reply-To: <20220523185226.7614-1-jumaco@dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1113cd31-2e30-4423-0635-08da3cf1ff21
x-ms-traffictypediagnostic: PH0PR10MB5658:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5658ABF203DE7137DE55ED4F93D49@PH0PR10MB5658.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCzLmVJDwROhRdqPBo19jwNfAoVQuUSaksqxKnLMxqev0X8q5EivgYuAz3W/te7ubvh4BXDvyZa6fe7/dS/92QhhA4ZpFtvcNDWjYgK93uRJpsLbs1WytqmbCGL1N5FcB96dBsktg9XpCQZxtQoJvq3XhRURw64CScx8Uhbiy9kNYvF9bn6tYEN8oH4AGyWZmeiDolG4soqj+KIs97+Ue+JqA3wYarS6ZIPTgoBcntz60flK7c4KctMhRYaZKB++cddUlEYoAm2ejQr67djDmtbCddcPLYyPK3mdENiVfr9aWhjuy3F0NlC93WonMY8XZmEdRLL3GUXczDZkrB73+b8aB8Ub8z+6wH6bSV3Lyx/etflg8xhglHU4IjnLUXsttEqYYHVuAql6+VhEE2HJrDlQjSFGjWGt7l2PQLZCYEHJVke5XhscJANc3Ab6KW1lI8c9Clj5nYay4f/nM5fvRX3VM2wPwZxRzhO/K18TLFovnXhGIImEZJA8Fn+sToef0LQuyEMW2FhSOQvDJGprODolW+zjYZ4Pm4CHVf0QqfVk/OKQwURFX8qo9+gAp1Zx7pmWHhGMwbUu/oj5lTJP/WUma155Ds+le9AyMmyv9cVclesdn8DEA80MPVAOlPlaA712duZRvCgIQZgGzedICv3SChuBULu6Qe8eCQW2tAFXCQJGu4+UrmS+pGoTmz/FUEHFBDwrSnzpMjZ9trqXiebiaTJ4QLiwpVNM1sSMFZXcx/ME18LWJV0KLypM5kK+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6506007)(2906002)(33656002)(122000001)(316002)(54906003)(53546011)(91956017)(36756003)(66446008)(66476007)(66556008)(64756008)(66946007)(83380400001)(26005)(4326008)(8676002)(76116006)(2616005)(6512007)(38100700002)(71200400001)(38070700005)(86362001)(186003)(8936002)(508600001)(5660300002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2lBU0ZZdzdtMXdlZGZRY3FFSUp2RUxlR2hIL1VBM0Y1bWNKL05PaFI0L1do?=
 =?utf-8?B?ZkhkQXo3Y2JmdVF3eDM1R3dPRnowYlYyNnBGaUVSMHlOSGFzVDlqUTlEK1JK?=
 =?utf-8?B?SWg2WVp6aGI2YWxVR0VFeWdicGFTeWROYlUwMmN0ckJyclhNNU45YkJ4WTJG?=
 =?utf-8?B?R2VBaUVMU21lY1d2cmJpeEJCN0VFNndsYklyTmRkR280eEhWb3dlamRXMTg2?=
 =?utf-8?B?ZnJrUzZacnRnSUhEVm5WSTZ6S0JYaGhXSHBVcElUNGY3VWJ5RG03S0kyeGgv?=
 =?utf-8?B?Y2ptVlZUbEM5d29tVEVSZ1djam9EVkV2bFhDcDIzTEhoZG1ESlptd0xERFZQ?=
 =?utf-8?B?K2JtejUvNGx1TnBhK1QzSGZiUU9rWWtIU3diYnJyejl6d2RFYi9KdEg0bXk0?=
 =?utf-8?B?RTFVTUVwQmxHbzcwVGZQYXlrMTU1b0lVSHNOVmMyTnl4Tmo1MithRStMdFdC?=
 =?utf-8?B?M2hpeU4rUllsdk94R1pnZnpqbEZGZk5QOWxnQ1hyNXhad0NXNGROT1ZNTnM0?=
 =?utf-8?B?NVpGNDgzRVRZYmdDQTUzeDFFZlJla25RbGdLNkVZcnlhZkVDM3VNZ3VxL01O?=
 =?utf-8?B?eFVlbU9yOS9YbnJZaFBpNDZDMkVGemViN3UrY08vMmxZZ1luMit3WEkzK0pG?=
 =?utf-8?B?bUZwaEhqUEJEbXNJV3ZNYXVQcDkvclgxR081UDZGMDlvU1VnN1Z0cU1FUmJI?=
 =?utf-8?B?dDBtL1hVNHdBMXV6MENwR0draTMxa2RrMjlzYmpmbCtuc0puL0k4SEN5UXc5?=
 =?utf-8?B?S2hLeXA0TE8wM3dFdThQcFU5alB2bkNyOTk2MWFkZVZ6Rlc4Z3ZObjU4Yncy?=
 =?utf-8?B?a1hNK0hCVE5remNzVXZFc0oxTlJoUnlwWHFUT1h3L2hKUHNVRi85Z3k4Z1o0?=
 =?utf-8?B?TG9TT3lLbUJGam9uYTNLWUQ4UzVScG9Pb2I0OHZWb3FnN3FHWkoxU0RGYTd4?=
 =?utf-8?B?QTRQRmRyRVoxbEhrYkFHTTZITXhub3p1RFhQdnVTQmY4RUVBcnNVT1h6WkdS?=
 =?utf-8?B?b0QrTkVWNzNCdXc2dm05WmFKNE0zV0N5NmtYQysyTVhWbzUxbFp6R0Z5UjNF?=
 =?utf-8?B?dTdjb05yT01lT0lSbzlzRkUweGJYNlRjUXE1dHQ3NHZRT2NFQmlZOGNCYktw?=
 =?utf-8?B?d1locXpURGwxc2tYelhLQ1o0MkZzN1dNemp1NGZDSkJUb3ZjbTFQV1JQUWZS?=
 =?utf-8?B?QkRzWk5iR3ZpdEpMS2xkU095S3RLYkowS0p0eEVHcmEvZEovR3kzeS9peU5K?=
 =?utf-8?B?ZWszdTVISythNnFJK3RCL1Y3cmE1K3NZdHRhUWgyNmUrWVpEdW5sYVUzc2VK?=
 =?utf-8?B?S2RVWFZ2QWs1V1g4TTlLNXo4QjJpOXg5aUx0OTRqci9RVnZYRTBjNlcwbU9P?=
 =?utf-8?B?TWpEeHdvcURCUUpENmZFak9GQVNiTzNHY3ozcVlsUFhLTU1DcXlTRy9mT3l4?=
 =?utf-8?B?QXVNbS9wSm53Q24zbHdFOGVzNWEraVNvbWl1M0tKNWlIanUwTlowSjRrb2FD?=
 =?utf-8?B?LzNaOFlSaHUyRUw5K0M5YUt4VUZKZSt1eFJMT21wbnhaU21Ic2VKKzNlc2hT?=
 =?utf-8?B?RW01dENuT2c5UUhobkJ2VXBMODV1NHc1L3BkMVFrRFc4SVJVNVFYR1BDazZ0?=
 =?utf-8?B?cFBhczRMUFdvWEl0OHRRVjgrdHJualNuSG1WeXNUdHExTHMyU1J4N2E1RW9L?=
 =?utf-8?B?K2c4RDBXbis5UndZN3BiSVA1dVVxV3lyK2tKdnJNcG1KbmRQRWZhOEFGWlhK?=
 =?utf-8?B?QzZrcndYa2FwR3lCVTNaSnpGcStVKzhvbGFDSDJUK1JwYzR3QS83dmFvTklB?=
 =?utf-8?B?RkJoUXJJK3ZoT1YzcnpUVFZsblAzZFdNMDZVbmdhNVNXTGFMZCs0VUphc0ds?=
 =?utf-8?B?QklTdmhWU0YvS0I0NmNVL3FoVnl3TS9GYjhibHp5UUhabmdWaC9jOWVOb2NH?=
 =?utf-8?B?UEkyQmtiMWwxRXdFNnlxTGxVSFNSTkZNNmR4bEVrWFZ3NDBpRFZtb3o5Wktt?=
 =?utf-8?B?WVlqU0JYV0RJZ0ViVzNxSW1QL2wxRTExdVViN3I4enluTmhHclY3Z0JSRk4v?=
 =?utf-8?B?VVpQc0h1V3h6clNNRDQwL2RSTzNCc0dNaFh4VVZPR0c4WmRjWGVFUG9OM0VH?=
 =?utf-8?B?L24yTFpzcTQwYW14RlRNQ0lGa2NWczJkTTV0aDFXUTB3MG0zVXlLbkdxZnRU?=
 =?utf-8?B?Z3hqSW5raXAvbDlIY0EzWm40QVBnbkdaUnYwMjZ5SlFaN0dXTTNOOUJ3eWZY?=
 =?utf-8?B?clhuSzRhekVXL0M1RG9PZ3ZuMjUzTVMxTnlrUm13eHlxMTFxWlk3WEgzVGJv?=
 =?utf-8?B?OXhLRFRtK25yU2JOckFmL0RDTWV4TUdVNi9EQnRJTkF6ZFNyMnFTcGw3WW5O?=
 =?utf-8?Q?Wc9vaC61NoYR2XrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA669E0C6728664086C7F0168121519D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1113cd31-2e30-4423-0635-08da3cf1ff21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 19:25:29.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LemVhMSTGl1TKnGJBXCoit6Ry5F1tYb5qYUbR5G/0a+WRVBqqtrLxNwugJlW2FW5L8C/sclpX0MtED5rB9hQIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_08:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230106
X-Proofpoint-GUID: iUhjTL0aOFBRhEtC5pJAhBItiognYVi6
X-Proofpoint-ORIG-GUID: iUhjTL0aOFBRhEtC5pJAhBItiognYVi6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDIzLCAyMDIyLCBhdCAyOjUyIFBNLCBKdWxpYW4gU2Nocm9lZGVyIDxqdW1h
Y29AZGV2LWRzay1qdW1hY28tMWUtNzg3MjM0MTMudXMtZWFzdC0xLmFtYXpvbi5jb20+IHdyb3Rl
Og0KPiANCj4gRnJvbTogSnVsaWFuIFNjaHJvZWRlciA8anVtYWNvQGFtYXpvbi5jb20+DQo+IA0K
PiBVcG9uIG5mc2Qgc2h1dGRvd24gYW55IHBlbmRpbmcgRFJDIGNhY2hlIGlzIGZyZWVkLiBEUkMg
Y2FjaGUgdXNlIGlzDQo+IHRyYWNrZWQgdmlhIGEgcGVyY3B1IGNvdW50ZXIuIEluIHRoZSBjdXJy
ZW50IGNvZGUgdGhlIHBlcmNwdSBjb3VudGVyDQo+IGlzIGRlc3Ryb3llZCBiZWZvcmUuIElmIGFu
eSBwZW5kaW5nIGNhY2hlIGlzIHN0aWxsIHByZXNlbnQsDQo+IHBlcmNwdV9jb3VudGVyX2FkZCBp
cyBjYWxsZWQgd2l0aCBhIHBlcmNwdSBjb3VudGVyPT1OVUxMLiBUaGlzIGNhdXNlcw0KPiBhIGtl
cm5lbCBjcmFzaC4NCj4gVGhlIHNvbHV0aW9uIGlzIHRvIGRlc3Ryb3kgdGhlIHBlcmNwdSBjb3Vu
dGVyIGFmdGVyIHRoZSBjYWNoZSBpcyBmcmVlZC4NCj4gDQo+IEZpeGVzOiBlNTY3Yjk4Y2U5YTRi
ICjigJxuZnNkOiBwcm90ZWN0IGNvbmN1cnJlbnQgYWNjZXNzIHRvIG5mc2Qgc3RhdHMgY291bnRl
cnPigJ0pDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGlhbiBTY2hyb2VkZXIgPGp1bWFjb0BhbWF6b24u
Y29tPg0KPiAtLS0NCj4gZnMvbmZzZC9uZnNjYWNoZS5jIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9u
ZnNkL25mc2NhY2hlLmMgYi9mcy9uZnNkL25mc2NhY2hlLmMNCj4gaW5kZXggMGIzZjEyYWEzN2Zm
Li43ZGE4OGJkYzBkNmMgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvbmZzY2FjaGUuYw0KPiArKysg
Yi9mcy9uZnNkL25mc2NhY2hlLmMNCj4gQEAgLTIwNiw3ICsyMDYsNiBAQCB2b2lkIG5mc2RfcmVw
bHlfY2FjaGVfc2h1dGRvd24oc3RydWN0IG5mc2RfbmV0ICpubikNCj4gCXN0cnVjdCBzdmNfY2Fj
aGVyZXAJKnJwOw0KPiAJdW5zaWduZWQgaW50IGk7DQo+IA0KPiAtCW5mc2RfcmVwbHlfY2FjaGVf
c3RhdHNfZGVzdHJveShubik7DQo+IAl1bnJlZ2lzdGVyX3Nocmlua2VyKCZubi0+bmZzZF9yZXBs
eV9jYWNoZV9zaHJpbmtlcik7DQo+IA0KPiAJZm9yIChpID0gMDsgaSA8IG5uLT5kcmNfaGFzaHNp
emU7IGkrKykgew0KPiBAQCAtMjE3LDYgKzIxNiw3IEBAIHZvaWQgbmZzZF9yZXBseV9jYWNoZV9z
aHV0ZG93bihzdHJ1Y3QgbmZzZF9uZXQgKm5uKQ0KPiAJCQkJCQkJCQlycCwgbm4pOw0KPiAJCX0N
Cj4gCX0NCj4gKwluZnNkX3JlcGx5X2NhY2hlX3N0YXRzX2Rlc3Ryb3kobm4pOw0KPiANCj4gCWt2
ZnJlZShubi0+ZHJjX2hhc2h0YmwpOw0KPiAJbm4tPmRyY19oYXNodGJsID0gTlVMTDsNCj4gLS0g
DQo+IDIuMzIuMA0KPiANCg0KVGhhbmsgeW91LCBKdWxpYW4uIFBhdGNoIGFwcGxpZWQgdG8gdGhl
IE5GU0QgZm9yLTUuMTkgdG9waWMgYnJhbmNoLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
