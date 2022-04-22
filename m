Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D050BA1D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448672AbiDVOdD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448666AbiDVOdC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 10:33:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C7B1C3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 07:30:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MBVhag019298;
        Fri, 22 Apr 2022 14:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Igufwe7gIBzzuOrHTUE3k1nT55eYlUa1Qboece1L5M0=;
 b=BpHo9v4/meG0knV0mkBCbPfP+O5yvWS6oE/xFApRpf0emIaEcfeLAaPkKpDMYb9dlR8L
 aXxK+035evy6ZTV+9ZxpDoSA5RLTdpw83+dPga3tp8FzI+wcjr5M/vnolcBGGwLVsXIC
 Sb9K8nAWePojcubQn5ZJiMP2jkwyeJYYPWoOkb5z3wZBjD3ni6w/k751lvOWAEtjRESi
 73bNpyVAR2KlZ1KYV4ZRGv9kRHPnHFeLdOZ8Ew5bmd60EhtKASIAeub0sFO+HM+o/u+O
 3EzZwb+9I7aa+F25db864BTRHNUaTxmPa31Si9Up0/GU08Wkk68/n9DGMreOVkSY61Uz jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cxghe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 14:29:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MEAInn018361;
        Fri, 22 Apr 2022 14:29:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8dqqf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 14:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgeYVH0vasjPlSSEgisVYO6BhNN8iChzhecNCgwRuJ8iOdONVPnnvxun4ki7AlyXBgwOzjHHq7WWto9Hk3lq1jv7G1vW7Xk7UB8Zyy34/xXrMjDbs12mW6qA4fWgpVqqIiu4d+TkTnHviVrC9fqkBcCKgzxZteXHA2UXRBY8xxGYQgLeugjWL3LikWyDHrwywfwkjU86IoPDYTXuNl3MmBxkax8QnE0quwIBNYdWA4592Q2iOUINts+k7Bf74wKkKjCXei9+kt4BDM1uzi88sMMu3gQeHvvHiz2i0bioXvnrDO6/n9zqknxQY4hdT4TMNqMxi/8DbYGekEGc6ebUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igufwe7gIBzzuOrHTUE3k1nT55eYlUa1Qboece1L5M0=;
 b=hDYUNk+sNzH4aOxrjbtiBayVP5SiqQkYTNNAptTd9fRqeCZj6vLrVnzPMHShCXGuYLWLy1GMaLJxSQBHATjiUxX+QOjD8+mlAc05p7fWlacSU7neyvr3fenb6E7bTcMiES3Kp1BV4x6Pc2GgtIYcWYy9EATTuxHA5W+a1iT3rg6KRzLJ8F42wzoXtQz4BG+1Ed8uka+B3Iz+57NNL9MzCOFpgMl0lE0t5SAGwT1NIlK5fcBQTst9oIljBx/eFXbsxTzInIbnEB5mcdaQZ0EoMcSl7eEmub1kC1y3nw2ptchZ3AcPbTwOlC3bdR/hhT6SE0H984n10mE7zAh0jd/7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igufwe7gIBzzuOrHTUE3k1nT55eYlUa1Qboece1L5M0=;
 b=HwkcE7mIENMfxMFF2C7m6zBa7bBVfSxBNE2rQROe+dtyJndEFk4k+10sTXJUtbEDhpTTxf7QjiJK6+A5gFVttvITCm5d6GV8WY7h0X0pJi7fim4BtmO4IVdGUnFeErIDZnEKAa/bcXPZQSTMWVWMUelTgdYpJD4TRR79ProZsEM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1617.namprd10.prod.outlook.com (2603:10b6:405:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:29:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:29:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Rick Macklem <rmacklem@uoguelph.ca>
CC:     Bruce Fields <bfields@fieldses.org>,
        "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIAA+egA
Date:   Fri, 22 Apr 2022 14:29:56 +0000
Message-ID: <A22B7B39-1FEA-4FFF-84D4-0FCBE42B590B@oracle.com>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6125f1f6-584c-479d-0fac-08da246c930d
x-ms-traffictypediagnostic: BN6PR10MB1617:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1617EFBF65301E64F0E81D7D93F79@BN6PR10MB1617.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQc1zPHKMkGM+UyzpTvMdaDeArrHFlQuSIbWwINZldsAtI1feoV1RFWQcaFhs4OMLCTfXjDpLi4pVGRnnxakIqZKuoFxxQSNuH41xMhiIPrwAVsMFxO3CYspXACFBt+7lCvv7/sDa7T4PhwhlMCUPxnJ/mP7qWS6alDPFfPyxAQzgb+6U8qydLUBXHoW4qGuwrFIv/qgoslO6mRLdGiW4qalcN+pd2/3b9I+MPLu+HzqQQNsvD8II82OzmEo7v93lmouDoeoI3I9NtVQ/tLEk2GYckYDbkxhoulUsO3xbL9jrp1hVxZmcRCk6w/Bfl1UYlZlqXMmPy1f0OAF2xjfvie1L+If/Ocn2CoePxPcRISO18Ql9cWJCoEnJZyxE1a5vk1xTronrmtmcWBzqttXgeqCYMEAM2M25YwRC8VgzJe7KrX1F4y4yCUbU5bWQpLhB7dHjjZY8W6rYIpHbW2pS/iv2JJAD4YPw7YzJXFFcGAu0LKoxMN1zKWx8VhwvsDf6L7BinfAh67NtVBjZVPpLtEScXi3b0LQELFlbK7E1e1RxAwKcWqyKD7CLASHrR5ChvU9BNz+0dq67LMsT4RAWd0Epqsp12GLs4jBG2J49uG5NKi1JJmDRNBp6pxQGsIPCttdnW8MSFlA0BaQm2pXI4hmmk1/1MblPxKa6006uuov/nArHrvfOGgh0u9BUa2tJ9RLPP9tU+/zbooTRTj7v/UP+ebV1owhsOR7OTgAjzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(8936002)(2906002)(508600001)(8676002)(296002)(64756008)(66446008)(66476007)(316002)(66556008)(4326008)(122000001)(38070700005)(38100700002)(91956017)(76116006)(6916009)(71200400001)(6486002)(5660300002)(54906003)(86362001)(2616005)(53546011)(186003)(26005)(4743002)(6506007)(6512007)(83380400001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xoOkWe9FZ0Y8YgXef2tqukSlw7zJ5pkVGoS5jAYL/fAFhLNM2x8dTQxj2fhb?=
 =?us-ascii?Q?Y0qDSvrC+KI7PZwnWZ5hItUI1PC8m0e1pXxmMYWXy2EqDe78zg1unTYRHvuO?=
 =?us-ascii?Q?7lgrmDlEWRB4xUZEDXdTr2UegNdfFnPmJo2/XeEm/shjVTYcLPda9ncfgOuj?=
 =?us-ascii?Q?HEc9/igphgfSFD3OvPudVRBmKaNr/UfNiKlOTW1aUleNgpdwUmiefHeYDlG6?=
 =?us-ascii?Q?KPvvn3mNFznAKj5QfyJraVLtwBE9GoX2ztO8xgWOEY9L61mV0D62pN007pR4?=
 =?us-ascii?Q?fM5NgEAt139vcSHix30+LDQPBGOhg04eHhX6nwfg5B/LAPhysiwOcU8VG5gn?=
 =?us-ascii?Q?ywm2I/eJvPRt8cqkAvRwKoj8fljd1kWurifz9d84g7kbtlEpJI7Tze7Q12d7?=
 =?us-ascii?Q?KdbW1Rs8eDHTU8ZtvzmHcg/u1Z+0MjBOFenX+cO7QB6AogWt1DLuaqEYnvk3?=
 =?us-ascii?Q?qxcaHF7KqitZmyj2HaNKPigyudoS95ZFphasaRlF9w98dvQk09//gVu/jZ/w?=
 =?us-ascii?Q?i64FDF8xbhI+s4Yy8RwaPNoGTLTEEZyZid3I6EoD95fDHfSSEPVvBPBO/SIU?=
 =?us-ascii?Q?/y1xrwO3B0PxiHZPuaRgH3y7mxwly2hBNCc9UfxsspmMLmHeJCa1/86kNoIe?=
 =?us-ascii?Q?qSwDeAwiZqkEFrfsmwavYxXg0pfdUSgHMV6dSDtGhjlUZs9smAiLweZAcUC9?=
 =?us-ascii?Q?i+PzsCZIWuDjzSW/QtT8cHXDtLln8kv4glyX0Z98Ab4frPC1vx9uJRraaVtD?=
 =?us-ascii?Q?mE36o2oeARiSjJYCgiLUlA9cxjKnL0xD2+teEWNqwqz/NwtMIScB4bLX/Z8d?=
 =?us-ascii?Q?xxvia9c5hnmhxRfKdFcXzYfYik5UUDPceDgz2wMgZLZkRfrnOvbdze1S0Z/u?=
 =?us-ascii?Q?eRRQs09L8kUdvdmZYJ3mZySoN1JKbguwwkMz9Erspa22Rgtf0mczUlpElK6L?=
 =?us-ascii?Q?gaGybZl6+m1IdNIRcHAa3a+lKzQXzZye0ka6x1/sAIc5HcgpDJRPP1NUPV82?=
 =?us-ascii?Q?1LjWP8rdIdhvrothdgZFCnTgmSYFuz6FQjkxexLTpGskFYzwuT69UBzs3iFO?=
 =?us-ascii?Q?wq/3kCnnVXXe5MRA2PY4HAaJmG8R7nM6uHcEAT0LYRp7RhHoBky97V9fEbUo?=
 =?us-ascii?Q?9ldoRf7vvGX3sT06ba9s0L5o8hYOMB+zBy/76pRW7ZAwDkAIyALsD6Zm+ZOW?=
 =?us-ascii?Q?xxm+otqq5AYulmsvkRpxDhdURILCJkmUyA4UnyBTLnwTOSEqtD3IWEkS9KJn?=
 =?us-ascii?Q?erq9CJQVugK930sLfp8TMgwFgGDTJo5rriPGQf87skBf5Tsg5sW0kdZPN3Xp?=
 =?us-ascii?Q?tKE3+R6z1HheDTU+IRdHWyWlI8gL5viuWLwaDnpWYNN4eLdh/a0ZR4i9KYoT?=
 =?us-ascii?Q?s2ZHpB/gjJ0bF92xv3vB8SMgpHyp/sSZW8WItMXttyMeUnSUk4BZ0QTqMh6Q?=
 =?us-ascii?Q?582+/bAzKXZe0ZpxbLY5YSgXVp1100Yazme+L8GkxpmAPqlt0lnncv9Guj5W?=
 =?us-ascii?Q?sgElM2m4xejDgcnIF1UvYimVVBWd31KbRzgiRUTRmrIWTKBhZO1Hr3G8dLye?=
 =?us-ascii?Q?0sgC1QypIE5RqgCEHzyr00KDdYdCbBKBi3X6NmLl4ZqXtNNkLhtBflC1vMLV?=
 =?us-ascii?Q?P68cvUO9Fxb6+CDBXgCAEm4rDdQgroqa8Q8joSYzuDNWyozZDsYNlj1RzD75?=
 =?us-ascii?Q?Y1iq1rS065OHSV7iBkpG1n8mIYcAoO4kTdxBoOqDuq1FUiK+W/4Aqfkmmq5o?=
 =?us-ascii?Q?Q+guWLK+rxTgORkui2PjHJ4Q4uZy/uA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD3B202657266945812CCD534EA57617@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6125f1f6-584c-479d-0fac-08da246c930d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 14:29:56.8208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs/vV21g6tFQU8gJDkjSMju5vqidKGE4OFgVR40cR44Aldhf5zmL6ppy0pUnTI3V8hL/TXbCbWsQKfUkeKizGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1617
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=766 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220063
X-Proofpoint-GUID: RcowX8m2gElt4EsIGy87RUmy0Sj7MbyU
X-Proofpoint-ORIG-GUID: RcowX8m2gElt4EsIGy87RUmy0Sj7MbyU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 21, 2022, at 7:52 PM, Rick Macklem <rmacklem@uoguelph.ca> wrote:
>=20
> J. Bruce Fields <bfields@fieldses.org> wrote:
> [stuff snipped]
>> On Thu, Apr 21, 2022 at 12:40:49PM -0400, bfields wrote:
>>>=20
>>>=20
>>> Stale filehandles aren't normal, and suggest some bug or
>>> misconfiguration on the server side, either in NFS or the exported
>>> filesystem.
>>=20
>> Actually, I should take that back: if one client removes files while a
>> second client is using them, it'd be normal for applications on that
>> second client to see ESTALE.
> I took a look at crispyduck's packet trace and here's what I saw:
> Packet#
> 48 Lookup of test-ovf.vmx
> 49 NFS_OK FH is 0x7c9ce14b (the hash)
> ...
> 51 Open Claim_FH fo 0x7c9ce14b
> 52 NFS_OK Open Stateid 0x35be
> ...
> 138 Rename test-ovf.vmx~ to test-ovf.vmx
> 139 NFS_OK
> ...
> 141 Close with PutFH 0x7c9ce14b
> 142 NFS4ERR_STALE for the PutFH
>=20
> So, it seems that the Rename will delete the file (names another file to =
the
> same name "test-ovf.vmx".  Then the subsequent Close's PutFH fails,
> because the file for the FH has been deleted.

So, Rick, Andreas: does this sequence of operations work without
error against a FreeBSD NFS server?


--
Chuck Lever



