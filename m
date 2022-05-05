Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773BC51C53E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiEEQm2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 May 2022 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiEEQm1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 May 2022 12:42:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A2580DD
        for <linux-nfs@vger.kernel.org>; Thu,  5 May 2022 09:38:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245FwlFJ013507;
        Thu, 5 May 2022 16:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gXxX5DE74XBFWk2JuVVvOQpiw1KHTgVsz7sgUei123g=;
 b=IxFHK1lSfXhfiDLt1dOGeBrLZL0mN+QXmbnBm1BMOM5TmtHwZWZcybSdqbVKTJ0GvIUZ
 by8OH1/N2qV3clgN+EGLpBIDBJd8wwE4tVORcXrIGEWxJPMw49CQ2btzZisihyhl37CP
 0UVkUCGzUbf8QqXsdV3wbfjz9PRoVZMD4n8kTZjxA4i+oep1d76ezyOB1kSFeP49leky
 JHgQ5G9OGsK2F6U0V69q4iDCMCjfRUPq7mrNPZukmVR9/SFepgnWNVlaS00VbILv5HtJ
 VnnDkRj0torQ4wcvCFN9uz/fC7cWdpkFLwrFksHTmiE7acXRSB7W+7Vuqs1PhB5cI3YV 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqskxt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 16:38:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245GZaXJ023923;
        Thu, 5 May 2022 16:38:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusah14k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 16:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHYrV2hJBPF4y5C9H7b9rpSwLk/PzpFErLVtnMr8zuufC+9MS6CBURMxuR5ePk86Z//Zsge7pGk0itslSS05+eXo2KbGMl4CwzlZU1Dk3Ydk9Aug0KGrDYRv+uwSwxEm1EZ6JTL+GDhmON2aqHBCJrvnLXQwN1sRPZ1uZ0Z+Bd1GebdhuDahaIX51C39U4zScsQOm/Lqbdl0/O8r9FJuFTTzGEAyvCA5oUQl96b/LilXkt+EPv1fLdgeXQejaXYcb9qeVkauT44NzJmEY7SnkpuZX/Z0s6JK+yx2I0AC3AqFoCdE0xH4L33OvSbAmHKFCPAMhTAFf4UPAhmqOMzSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXxX5DE74XBFWk2JuVVvOQpiw1KHTgVsz7sgUei123g=;
 b=mhO5LJbh0o/zb5vcVSGi5JhLa2tvAPKH+dVTH6oVgFV1Jf9YNTRdOiXuwmZYxZdfsYRL9DpKBDWFswM1/PJdhhOKO8KLeAm/ZylblYUED2riRb33XOLDgtHXJhy+1lyLSZBEqBWN+HvEh1gBbHgc0WfqhcTm/GyfrYL56O8XCOkfpcCFlVdbURHgw+8mN/gknF9rMLURiW6xzU9sebZz4WNelZv0xIgIiHRHs/E50Q+rcQ9EhSYTsmKSUfo64D04fqd6xhOeWlQWjkypzcdscdtCLQl4UUZ8Hn+UySGSPUoXjAMY30bwstc5uTTd5/ujXr0lRAP90hP0ZbLmA1nFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXxX5DE74XBFWk2JuVVvOQpiw1KHTgVsz7sgUei123g=;
 b=dClpF9EHpvZk8vMe6HX7JDrkOLNX9MotFNmdeCzvIqfBEDZRKAbd+vw6koCZNTMb7CyqxsQpXNGtgO3TPwFZuLpWw0bD/3gTHHgT7i9VWjT8emNKMzZXipYgMN/nRk6BGCa9NiIVnoyVD4xcWaPu6kgysTMMJY/N1fxuHFb2uss=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2123.namprd10.prod.outlook.com (2603:10b6:4:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 16:38:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 16:38:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "andreas-nagy@outlook.com" <andreas-nagy@outlook.com>
CC:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw+AAMzyz4AC9oCjgAyG2mCAALz5gA==
Date:   Thu, 5 May 2022 16:38:36 +0000
Message-ID: <D267ABA2-A071-4406-A218-919DC7414DCF@oracle.com>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
 <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB166592CDF7C78BD68CC153498EFA9@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1665FA51F62F82B006FD97168EC29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB1665FA51F62F82B006FD97168EC29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acb53ab2-d1a6-4eff-49e9-08da2eb5b3c7
x-ms-traffictypediagnostic: DM5PR1001MB2123:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB21239215B5F383AC6F06200893C29@DM5PR1001MB2123.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dI5efNwA+AJEme7xKISyrGdYhgil9cQYRkAbL8Yfu40MpDxd09fpPGlmIWPqmGltWRjtGlvOdYfVtfAlyW18vdCsMi7kU2bisR4ISQcb4a/zpqZAd1LH6V932v0lAh4Ks/yZCKrVWANmpy1llxuhalPQtIrkUKg9/ihyhqL2Mi1KQ84YAI3Ymwi7Jy/+ZG9k/awGGLS1DRK5h2ewjTej/Gm24l+PBxupKPaZTnV901sIxw2XXSszQmJ9HnUMntlyO3rJxHx9O05vjEPvpVziTy7qEhp6ULvGtW5irNWjTIsrUY5B+WKViYWBWsKvkpg3uJsYvq5szCIypUjwgy8CBuim48Up4VJyHk8atS/qrTukn2srN7yqUtxNjHttSivrsG7aNXV/03ylxFWLQWhgbNPo6NVlqHePnS70kvvwZcHQj+6Qp7DKxhnJfIPqVwU40XwkQjhzLW39QQjIuKqKwy0H2y3n9lUa3t+yDEkNaNfpr/O1NTcCAgvcOM3+OEF+KLXqMePaK5F9IbiQhhq8E0LNgy2k2wweSFhuEu4ACNkhrBaz2VpyXVayS3un08fcHMKgU4HZf1oPTHBDE0yUNpBD+pUXxtN/wWI+3KRBHu9rzyoDWoA9WXxW5ZYYgW/D+bmWlLRmersoPQDrbuylhvuNgAmYZU8xxaOdQTFZG7B9Te2RZNV4JiYS2g1PMg1Ek+lPfGuFoVLf9a5hhoxO2GJ+iOXHZFxyAlWC5vUcB5Rk8PR/pAvyEnl3FCfwGH6kmEZBb1GNc6xVoJByZIvJ1Xyg/MFN/LZFZA10HTM02amtDyClK/ZD46C8oqlz18nW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8676002)(66446008)(66556008)(66476007)(66946007)(4326008)(76116006)(91956017)(5660300002)(33656002)(316002)(64756008)(54906003)(6916009)(8936002)(6486002)(966005)(71200400001)(508600001)(36756003)(2906002)(122000001)(53546011)(6506007)(4743002)(6512007)(26005)(86362001)(45080400002)(38070700005)(38100700002)(2616005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Id4PtSS4bcf1OfwiXWejG32v0E2jTz4tOwBJ4Wx/tugQ90RqNDog09syJbcb?=
 =?us-ascii?Q?ZZxukkQ5rLAI1/7QbEWkeK131YQ/koWq58CFpKFKNewJEJLQ6ouih9AnDP0v?=
 =?us-ascii?Q?qfMY3w5zLd9NCRraW1ofziAxZV8v3X606iwQvWmhyNr6J49pVz99gR9ojXcs?=
 =?us-ascii?Q?qbUtrrTQVqI0eXKe7lE8t4xjlzgqdpG6HU7eJxI4cThr8qX8oZzQ9nJsBGiW?=
 =?us-ascii?Q?KEKOsn3fM55iq24FVOqa9+yVJEfu6oXCwg6YpUYIDULAZ+fZqcDeD72A6viC?=
 =?us-ascii?Q?jo1EyZAoMQpDebRyDEgST/Vds0rBgExfIpSVrtXaFoA77joHjjy+Tegc7YjC?=
 =?us-ascii?Q?7+M1O8ckpAFRg2ZEuSrdy/3DT2jKR3NsNp7g3RBUaDJQ5VuBxum7orKzXLXS?=
 =?us-ascii?Q?DoNRemhdFQUFiAQ8Z2NmZu9Akcvvqd3itaal9Cmr28hhqhwRFAm5s2q+HhYX?=
 =?us-ascii?Q?3gafYPHmyI6/dASOsL6Sa9DwSfQWr3ssa1kmEADIjCfZu7txuVdppLgBOfsn?=
 =?us-ascii?Q?2siSQUk56kXb2BKJJlxLVV6pPwaFLvALEuDG+5P2vs3ClicnpFznrbYF0H4k?=
 =?us-ascii?Q?0BNRiG9rGi0vACTl+VCDYzbWOpgTOVzEnm4wAsyw7y8fL9mW2Smu9RFDSq14?=
 =?us-ascii?Q?ibBtJW/5IuahQdKvnJqUb/4l7enlWIvQAcbdc7hmQiG9IEvkfcFN1Ao0WTmH?=
 =?us-ascii?Q?Wwrafd9luN2jOOZrdNRYa6F9NCdGeRc58fiQL3vyvEtUHkUTI+sxxRuzUKTD?=
 =?us-ascii?Q?47+9nnkSPkKiu7Wj4HdOvQIfLPHMoY+UrSDqOLlux7PieJ1KNteXo7quk/VW?=
 =?us-ascii?Q?v+EfGF5Rb3KLreBwnOfJBqEPj9ymEhrCuNKh5kqcZr7niJaT9zsqNvBjgkGD?=
 =?us-ascii?Q?jz0XDlEVHcrFkRBano5son6zoJOToqTEIO+/wAz/EPUeOfzMaDnzHxG0sLpP?=
 =?us-ascii?Q?ppf65m+HYGnp4kJvbPBxTd5H0O5641NVJcnzGXdpP1bHzty03xENKlznBlIT?=
 =?us-ascii?Q?bVVw+hqN4CBm2pcJrmGdaP1T7hzjCCHnz07c++f6Vt90RIQIxDnDHSEWvcwb?=
 =?us-ascii?Q?lxez3sGaQ5aGmnOSCnXSdTBopkQDjUmEkVnwORDvHZfFsZ9Pllct+zen0oOT?=
 =?us-ascii?Q?biX9ALtnxZ4tciPyqO1tixLlYly5ihe2paIekKe6+V27Ec3sFrPfv7VOR9zk?=
 =?us-ascii?Q?f5mqONDMkCzdkrKVcOvfDZq4H/ysu3Gl2aCZW1mSt4C7TdB3X7W+NL6b/uNp?=
 =?us-ascii?Q?zxUXaA7LZ9Do7zb3z1RG9eXIvjTTNYQOZM0ZtVTxVbxmbRHogxNzjnhAAHq5?=
 =?us-ascii?Q?McZP4VmEtZpHrugzCfyr/SDdqAyDfm58hdDZVUCAjFwfebSouHy+xuWg6J1g?=
 =?us-ascii?Q?5lrL2E9xCy+OO79R2KJSH1YyFERBZxCF53iqNd2aKNcbQQdkMeYMqc/LDHap?=
 =?us-ascii?Q?/Js1OXH85YPwCc9+8yaiJMWQhWp8/XNpyQTSeXkp3O7hU/kXPO6xlbXvZIxL?=
 =?us-ascii?Q?+qrHPDSLssSfBEvDTb4zirJJA7U2i8voGnfLj7SHI6uXOZvkaLWUqfGuBDSf?=
 =?us-ascii?Q?km49qdFUDcp0luKOF0OHru5DQT1QrIQmlMXUHGfblsYiMND3nQyVxlikhdVa?=
 =?us-ascii?Q?Sv4eU0HdwXIJ0h+2iyhjB3f1Bj+jTXbNWlztfpxpg0NnAH4ijveflo5OD0Iy?=
 =?us-ascii?Q?s7smbcrhYRaWek4almxYo/2GCeEPCCd9h+uQj59vg7rqvt5E2sL1/x8X85kC?=
 =?us-ascii?Q?u0mYMfRLNGJQe3GsuBohvMPoPdH4xZU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46B4256E188C754BA79950CB5CF3B1C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb53ab2-d1a6-4eff-49e9-08da2eb5b3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 16:38:36.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNiA/U7sv0JcMX34vMbYgZzGf2C1jPD2fSdNCiMrbTWuDYXsU0uU/Gj4Qto9A6Sr3Ioh0sn/o4RX5G2/pNt5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2123
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_06:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050115
X-Proofpoint-GUID: jM09Dqw2HrRi0jDpFGsS-JCxBw_nfbnH
X-Proofpoint-ORIG-GUID: jM09Dqw2HrRi0jDpFGsS-JCxBw_nfbnH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 5, 2022, at 1:31 AM, andreas-nagy@outlook.com wrote:
>=20
> Hi,
>=20
> was someone able to check the NFS3 vs NFS4.1 traces (https://easyupload.i=
o/7bt624)? I was due to quarantine I was so far not able to test it against=
 FreeBSD.

I don't see anything new in the NFSv4.1 trace from the above package.

The NFSv3 trace doesn't have any remarkable failures. But since the
NFSv3 protocol doesn't have a CLOSE operation, it shouldn't be
surprising that there is no failure there.

Seeing the FreeBSD behavior is the next step. I have a little time
today to audit code to see if there's anything obvious there. I will
have to stick with ext4 since I don't have any ZFS code here and you
said you were able to reproduce on an ext4 export.


> Would it maybe make any difference updating the Ubuntu based Linux kernel=
 from 5.13 to 5.15?

I don't yet know enough about the issue to say whether it might
have been addressed between .13 and .15. So far the issue is not
familiar from recent code changes.


> Br
> Andreas
>=20
>=20
>=20
>=20
> Von: crispyduck@outlook.at <crispyduck@outlook.at>
> Gesendet: Mittwoch, 27. April 2022 08:08
> An: Rick Macklem <rmacklem@uoguelph.ca>; J. Bruce Fields <bfields@fieldse=
s.org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> Cc: Chuck Lever III <chuck.lever@oracle.com>
> Betreff: AW: Problems with NFS4.1 on ESXi=20
> =20
> I tried again to reproduce the "sometimes working" case, but at the momen=
t it always fails. No Idea why it in the past sometimes worked.=20
> Why are this much lookups in the trace? Dont see this on other NFS client=
s.
> =20
> The traces with nfs3 where it works and nfs41 where it always fails are h=
ere:
> https://easyupload.io/7bt624
>=20
> Both from mount till start of vm import (testvm).
>=20
> exportfs -v:
> /zfstank/sto1/ds110
>                <world>(async,wdelay,hide,crossmnt,no_subtree_check,fsid=
=3D74345722,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)
>=20
>=20
> I hope I can also do some tests against a FreeBSD server end of the week.
>=20
> regards,
> Andreas
>=20
>=20
>=20
> Von: Rick Macklem <rmacklem@uoguelph.ca>
> Gesendet: Sonntag, 24. April 2022 22:39
> An: J. Bruce Fields <bfields@fieldses.org>
> Cc: crispyduck@outlook.at <crispyduck@outlook.at>; Chuck Lever III <chuck=
.lever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Betreff: Re: Problems with NFS4.1 on ESXi=20
> =20
> Rick Macklem <rmacklem@uoguelph.ca> wrote:
> [stuff snipped]
>> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostl=
y
>> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that
>> tries to subvert FH guessing.
> Oops, this is client side, not server side. (I forgot which hat I was wea=
ring;-)
> The FreeBSD server does not keep track of parents.
>=20
> rick
>=20
> --b.

--
Chuck Lever



