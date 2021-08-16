Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6763ED736
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhHPNad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 09:30:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38346 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241188AbhHPN1M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 09:27:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GDBrS8026565;
        Mon, 16 Aug 2021 13:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kPNw3l7AcEzVFfqI6ewdxeVVvFszBoJcgjehtEBPzKg=;
 b=ckff2KelNugMLZyRW8FV5nPTRvuHFkdn8LnLVorOkygDeVxtQpKfsVCBVyIiKnvwkmhY
 pw14dwM71fDoyrdQ94rmeJ+Auu6EWLfbUYQNsYzACce9wi0xsHeIOdUnj8mx9ozgw28P
 o3BReAwvZeFn8vAhq1TVbZFMOTWNJRN6+pMnemOAa0PcyHxpg7z03tqr7pGonpItWyZK
 kycn3+VMsWSvme9dt2Fy1ccrWdG+1NVThrB57BGUK0emCuB/6WKfY9AmVToPFVBy/cvi
 X1Uc3NGTBcnOg8OsXAYLe9oxmbddptIS8dHkzMzhN+/FXoR1TWwhtkovvgwmWydSy7Ck VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kPNw3l7AcEzVFfqI6ewdxeVVvFszBoJcgjehtEBPzKg=;
 b=i+BvVLghyfATlkxhY+gWo/YNytzoJssyu1YjE9II+m7OMskxuBMETtbfO18JA+OsOuvK
 TDOrTzIstArt2TNJQtezj+Ca0vYPz57Ora6jfurKFPJWRlN/9Ydp7xr1VcYqyUzdW1rq
 qVyoFyUc4e558jCK9CS3RFxlEcOof85FsQNukkr2o62NIaW37BnIAdMsnJYneiw0w49e
 7+jZD6K3QRvObpMGMnVTNxXg2m5cwul8g+57ZVWPCf9WmlbPryMGHSV3HZmL1coo+Tkn
 Gfgj/axeV48plEUWnl2Fm0ZnfJvffkY7W+tqKgtwVFIKai8wLpopRDN95T/eT0HEagb3 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd1cmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 13:26:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GDAg6T105845;
        Mon, 16 Aug 2021 13:26:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3ae5n5pgse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 13:26:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beOxl6mXrdlI2EbxklRA4vTpxxZIiMa3u/7YwbaSIpoT1vsyX4YjlmYQUP3ko4IrYEj7ULLheelnw9YVTAg2jakjrGAjkDj4UHIoeKmBZcc2zBofx1ATgPatrsSLfdl6u/QhSvRXfbiHS+xAmgrRpGAnPduTQMscbg0Yxzc74cRAwmFih+rstj7IOq0eFHr6CLdWuXwQqsf1l94AIJ1Uswxkd/+UcVyWK13bniftck4VALWZpnY5yC96C4U3w+EiKX69D8Egt2+T19sVB40jyDZUJuM0KfZrti97o/STlC9zI0yiRi4sD1qiEjD5ZmtHP+ayelRRBrW03n2xt22dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPNw3l7AcEzVFfqI6ewdxeVVvFszBoJcgjehtEBPzKg=;
 b=XwRHj7drmhzplEamsc+GbcODIGc9FGA8nfNgSowzXDLacoa741+J3Lp+8GGwkCID3XoUWDUEDrdWUiBB9x1pBaJmFyLjIY5DQSEU9Lk4oUm0T5uTWKjnlg+YXMigbP9+/8un76wTJYMeU3Vl3KaeZMX+a2rMa0SzGDLH7y8wSzJtN0R8amOU4iWtUSmY7jzEUPO/Yi+83Tvw5XxSFgwQicu6BOJGLSiIR/u+f4WvvqSfEmcvycS4kJCx9fVDXD08+aAntZ3a86IYEHAHwwX+gTB4jS9Gk9bK8XmqXQeGVbQ57PhDnuhaHYOOr7iL3EcIAgd5t3GXJ2OXg2fnRq/1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPNw3l7AcEzVFfqI6ewdxeVVvFszBoJcgjehtEBPzKg=;
 b=Gft07U9+isLu7u4bRmj8D7CP1RPTPbCDXHf6tqd7Rv7++HSApAG58r26QF/4umaXLv5GdSC0QZWMYn21FVfQlgMlahR+SzB9Kz6Ae/SA8YkAQmn9b2W6pMvRrGMD0S3GB+ATLCvlDqlmZWZpuu7g4IgH/dRB22zBXgTlD0wycR4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3222.namprd10.prod.outlook.com (2603:10b6:a03:150::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 13:26:29 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 13:26:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIABnm2AgAX5FgA=
Date:   Mon, 16 Aug 2021 13:26:29 +0000
Message-ID: <716B2A38-9705-41D7-969B-665EF90156C7@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
In-Reply-To: <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971f70f4-4e45-40dc-eaf2-08d960b974ab
x-ms-traffictypediagnostic: BYAPR10MB3222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB3222DE42E0A1369E8C78047693FD9@BYAPR10MB3222.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Hq2UnwO6DRG3uR/GXdSdttfTfHYOpYDlddbbrusyG1DOrBDYApIhUSLoP8N7UxC61yAgR6UC57Nwt0vCqkVHYm61TuGaVcX2SaqC+SNpF9SI5+w+MW5QLUf3IDuVte74q23hu/xBD7Q8vTQJe8VPGtRCtQChgOkiDWsjFoJstkmLXpaQSeuSd0xoIvzGdtEF2MhESse6gecZk5Q5z1J5dnYUUXzya8BfCZbl7UCJKfiyW5DYANcu6eEi/JFQNxjWrSeJYInyhhdWHu7Ry4j5EO2Ptv7dT/gwAs3goM9FTn5Xfdx1NjINfb9JNaasBOpM/fdMu91/SOP6aVHTBQTXBV738wWQUBfvtPwcv7/ofEpXjuFFfhuAxSPTKRw8RVTyCbgWIqEQfVxedoc1Qn4BBiug6XYafGkYN365wKB5DO4iKwCHbp48K8tNAVBe9xEyF0uP4mFc4beGCUKpDJm7vMxjt8GGBOY8LREq2jUB2eyPI+UekoOgmujaSfqwDdjuFgTTO93mRPgA0QS0c0MDW2uGjwHk4UvQAP2piVDUrD1e2HgzqSnur/BZQ1SRoKYfXPbUcPHYSZwoRdJ5KUs2XSs7rLeMNngVx6/tCbzLSKrOdo1GxDWdIMktxxszxEQZTaeivEDGYxe0jojxfC4dEjlTWi0GSfRV4Gh6fLymLS5NC/614NvNtXn3RDzh/k+tSzY8RG+IaaRAY869kM0Yxfp+NxKk9QsaJmCg6n24PsTqRaCacpOWD1pxslGGkrl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(2616005)(86362001)(53546011)(6506007)(83380400001)(8676002)(6486002)(6512007)(8936002)(33656002)(107886003)(5660300002)(4326008)(508600001)(122000001)(71200400001)(38070700005)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(66946007)(6916009)(186003)(66574015)(38100700002)(316002)(54906003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nYLINPjobbWVNcCUT0zxi2wymeh4F8Utp6b0Q8ILq1ThycTAHk3WxYYoZ60B?=
 =?us-ascii?Q?mPKUuVTuRdlqQKi/bmCqngweLbQTPvASuqZITkR7L8GyKJ6/nVBBeznrQSa0?=
 =?us-ascii?Q?TlL5r2fVl9nn3KUVcf/X9ZDaNJN1b3vj3/cqmIHQ4kxmOM5RiDg/u27ceI1L?=
 =?us-ascii?Q?RIgNJdxHc/DGBi3YN8aUu0JIZDMAIwzTC2fImVubu+9onXG9UwQShRumrh+O?=
 =?us-ascii?Q?1fHWpiLFPnKBKVb8CANnEWd5u8huaSegWta0wPcUfooBpmrN0wEqP20V62ck?=
 =?us-ascii?Q?FTO4CitzHcIOreL5LBcbDSAHp4u2/6BQqvuonUdVGHeMGBkIIAVM8fktiuPM?=
 =?us-ascii?Q?EyHFI5BKRpydcmxMSLkt24PYG7wH2g6ggy08QzJbkUOteGHQnTJBxmDXppHI?=
 =?us-ascii?Q?UnWELeksJIg0O0ai0QMyXo6hOV4GhsQzY85j2bnVDjdvHQZIwz5McI3glvSh?=
 =?us-ascii?Q?dQnT0riNhqbu5LzoCKrJn/fuF1sSIppdud0srPmW+EhKBPpllATrJCrh/T9+?=
 =?us-ascii?Q?18QwbKgWIRDNtrNY+TMk9DpOZsL4LEffva/9pXSAaFTg43PBbUoy/+aYwxnl?=
 =?us-ascii?Q?jhtGcNU7f1fZgQqfpilZNbau/YJu4vLN8n7SPpKiyjNd5/6f8eTAx0/8ncgs?=
 =?us-ascii?Q?8W/00s4cBs8IFpg8IFVVCebIW2LEo9SOZTyMfu1pgOUxMsg6Vtk/RChU2nu8?=
 =?us-ascii?Q?6nEdF8V7av0kiqoNaViZU3UZfRQE77ox8eCMjNnQZfRLtoOZk6i+ysLBf+fp?=
 =?us-ascii?Q?xxan9cnrqcX4NuvuAxT1+kVLDIM4qGkbvz3PjfJia4ucWRNa2rQLWckx+qIu?=
 =?us-ascii?Q?o7dENxZAQ9riYf3LSDV9sZrbfF6gycYjug2ruBZgrBfFI2J2OsfOEwIupqJW?=
 =?us-ascii?Q?BKC8IkBfrq+KQAr9VhmCj67DgH3Q+z3LZN30VdY0htUKIpc7IBtSjC4kP+1g?=
 =?us-ascii?Q?/2yF8sYgB5IMJBPaQmclectH/FvfxNTY7Qj4FTofYyT1VZEsaHscaDP5s+LR?=
 =?us-ascii?Q?k6pSLueCoD/xTqg3gpdaGTFdN9VbSJ5QtBjRoHHKjbYPq86HZTQYnlPYR5CG?=
 =?us-ascii?Q?0a/ATGZugINxoi5gnRaynOMifpUjtxohKydYA2bVInGZquP6tHIrkueipUnK?=
 =?us-ascii?Q?bHP0vwcoIGzr3JvOh5O5MEwi3FqP8E+r5X95BgcVIVVGByjiINAGRCzsW4Um?=
 =?us-ascii?Q?Dcl4BdvIpWYrrVZ/EvitJojg2EP7DO+ZR5fHLnUuxz0vzjTBVKLONksf7yTr?=
 =?us-ascii?Q?JFjsdUj2qKVR/BOeQmkdaeOe0kNSl+onWegIGnUOCkehadgnVa5ApCG/hVRS?=
 =?us-ascii?Q?PovaQgrhHgDKRel9G5cYYl0khPuUZ5C5qIxyo3YvBr7GbfTId3ivDdmlQi6J?=
 =?us-ascii?Q?FfMWkSzDhlsE5m3CRTBEV2X+v6ywRmw0eUelcFvtfaiEImi/MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00446C63CCC2B748800EDE30FEDBF131@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971f70f4-4e45-40dc-eaf2-08d960b974ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 13:26:29.0732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSKh5ZQRP2n6sISCE/4poaMlGdkwOkm9xSX7LwE+jmASiaWzSEft7aedHLnk8wSUycAl3DRViMyy4KkXQ5DtNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3222
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160084
X-Proofpoint-ORIG-GUID: ENZZ8OFwh_d1qQeg5kyI0DfK5dnRmjxS
X-Proofpoint-GUID: ENZZ8OFwh_d1qQeg5kyI0DfK5dnRmjxS
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 12, 2021, at 2:13 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 11.08.2021 19:30, Chuck Lever III wrote:
>>> On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.org>=
 wrote:
>>>=20
>>> resulting dmesg and trace logs of both client and server are attached.
>>>=20
>>> Test procedure:
>>>=20
>>> - start tracing on client and server
>>> - mount NFS on client
>>> - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (whi=
ch succeeds)
>>> - wait 10~15 minutes for the backchannel to time out (still running 5.1=
2.19 with the fix for that reverted)
>>> - run xfs_io command again, getting stuck now
>>> - let it sit there stuck for a minute, then cancel it
>>> - run the command again
>>> - while it's still stuck, finished recording the logs and traces
>> The server tries to send CB_OFFLOAD when the offloaded copy
>> completes, but finds the backchannel transport is not connected.
>> The server can't report the problem until the client sends a
>> SEQUENCE operation, but there's really no other traffic going
>> on, so it just waits.
>> The client eventually sends a singleton SEQUENCE to renew its
>> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
>> flag set at that point. Client's recovery is to destroy that
>> session and create a new one. That appears to be successful.
>=20
> If it re-created the session and the backchannel, shouldn't that mean tha=
t after I cancel the first stuck xfs_io command, and try it again immediate=
ly (before the backchannel had a chance to timeout again) it should work?

I would guess that yes, subsequent COPY_OFFLOAD requests
should work unless the backchannel has already timed out
again.

I was about to use your reproducer myself, but a storm
came through on Thursday and knocked out my power and
internet. I'm still waiting for restoration.

Once power is restored I can chase this a little more
efficiently in my lab.


> Cause that's explicitly not the case, once the backchannel initially time=
s out, all subsequent commands get stuck, even if the system is seeing othe=
r work on the NFS mount being done in parallel, and no matter how often I r=
e-try and how long I wait in between or with it stuck.
>=20
>> But the server doesn't send another CB_OFFLOAD to let the client
>> know the copy is complete, so the client hangs.
>> This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
>> other CB operations suffer from the same "failed to retransmit
>> after the CB path is restored" issue. It might not matter for
>> some of them, but for others like CB_RECALL, that could be
>> important.
>> --
>> Chuck Lever

--
Chuck Lever



