Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E55753BF8
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGNNo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjGNNo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 09:44:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F830FF
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 06:44:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQa2S001094;
        Fri, 14 Jul 2023 13:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KVwVU2ccTORoLNi7sXLb2iU0umMx2K89dlbbHXdctzs=;
 b=KgBnXa38srnf0J7yMUqJxHen2upGaqDZabxPZAjjx5RBJn5ukartbbqfrOtip/Ad6eez
 7LCH87UpT2GBMpsObA81A/9/FjdvAVou2b0CK8EWL6cwouMw+LMsbTnwWqLgk8+UODDk
 P86RURgzf7GjsKAoXoEuuIg94VlkTm8oAFX88gzjf8jInAo0P++KlvUx01GFdOqFC5mI
 JVtVxS45LSmK+2oSUYeq7b8kYuqPeqkAGTwPrge0WBDrhl+U6Ucl3FP/6xQKwUM4SSNt
 jvhYQdchMdjs0TDjZuuEwoZWv7Hew41EytL9sAdEkEu0ym6WVrA50BjjYPW0lQA6c5wL RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtptn1hqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 13:44:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EBn36b007816;
        Fri, 14 Jul 2023 13:44:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvrnumn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 13:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpJ/TFFWYbw3RUpc2Nq/RmkOxDdOWfji5tUJlVK8It++0B+2p9l447w4SgL/NDUnXuCyxnMYcz214h3SsJpFcTMUroAlpG9zK49AwezIqa8lJmt0pv1g8D1/M/PkAQKYdlz61/lNihExNqMLg98TGRsm6l5C49XySvYlMlUEWMKOCn4QY766yPLcp+SEXZQFio7irMhhJA5uUQKBPhTg7Gx2SHMc9cupIzwnwCxRdUdc4bqG+rvWA3FxfcLKhuF76gKyICc1M0oOPksCIIB97FKXOI6kQTEqyhCaapwnj6Lg1DxDOiq6ywSFD5THVnAfGzv/N9USQfFMmYENKCbYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVwVU2ccTORoLNi7sXLb2iU0umMx2K89dlbbHXdctzs=;
 b=jUrHXaaL23smNzr6uNRztin+eUEYTQTJfYuYRRwfVM6dBn5MNe1MqHrAbz40Vxx4PiE7f1lA0moh9qnwH1hlf0+IQ8tGljuYFQo37Nwm7rLXA1k494cg6TXilc19S+HibJXRyH4ZkNDur9f1AfQPU7tF8eGjEBXi+9S71TcMJHxJc//5C1B3nnA8kiM4B0mfcX2183IPs0AYcPyCT5zsJcRzNQpTCtH2SPi7yN1RGOryL+QsbnEwXuRv4jcpos62gQvZmsb0rkI2k79SfC3pqGSZS54A0oGpcCwboVJIW65zLOTJjBm75ZlB0gbPV3eCnzm8S/4vRJXxC3Fh1tXO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVwVU2ccTORoLNi7sXLb2iU0umMx2K89dlbbHXdctzs=;
 b=INvOYuMdq/0PinoRmR1uiO7Z75j1fEbwrZg3jsvXFYCYCK6V7sREAhVmoJha5OizDznO08fqAdb0FZqiq8VvcPdqLUzHV+jz4BNyWqTmHuWy7YV34FrKaF9GcrLY7ODravIT4yLJnO8Wayij1hMP33rx2Ntl33uSuxTykhakg+U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 13:44:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 13:44:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC 0/4] Send RPC-on-TCP with one sock_sendmsg() call
Thread-Topic: [PATCH RFC 0/4] Send RPC-on-TCP with one sock_sendmsg() call
Thread-Index: AQHZsqCjr+BA7NsSaU28xbrPUqTFRa+5SDeAgAAFLoA=
Date:   Fri, 14 Jul 2023 13:44:45 +0000
Message-ID: <D47A701B-C3E0-43C4-8BE9-03426EE326A4@oracle.com>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
 <3376204b7b0335721956c45f22b10a2ff41aa276.camel@kernel.org>
In-Reply-To: <3376204b7b0335721956c45f22b10a2ff41aa276.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB7482:EE_
x-ms-office365-filtering-correlation-id: 77cf92b4-1e20-4928-4ef4-08db84707c38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dirjHmPhl+bSNazldapP2VXgjWNk8+SbvfOaV2Z8573WcB2QC6/qJWgDFkyLbf8bylHQsez5K8FnD+/s9RaCFNcEMAaSYes0BwZfRWsIhZiH28DbU0Pek3psqB8DLr2552vv3p9VSGhIyZ9lYLPRi4UZj0T1GNerMuwlNP2BFWH9YluM/LN7q+U231WoSE0Fk34P8nJba9rHjIvzIyP8RsgPOaV20wk1cWXJ76s9HsjwzNKBr+DuBYG5tl1R0HOByfyXvgzfTx/esZGOR8wiurLFECchTz/5q824k2L4QtaaeTUEQWEpgMj6CFJjXo73F31MhXwXnXJP0+Y3EggvEXVacbmqotzFFm32K3J6BDKCWu1XeHDGw3fDWkjvS5BwQB2sQYvDt652miiNZ93jFK/e8dWneajU5GhttKN3LjKJdQeRaHNwRArYrZhsO3W5Hjm7Yk5zRBLT8zBsX2emvwxSOUDP1ipqhl1JeNebujB+I1GNQIzmuPX7DQxoxs017cXdO2xghi1tVuaKyXxO1Du8Q++jD84QTWr+mA+/qHoZpZM+qCnHcYB5ZeZilqGs8BGnlmuVXxv+3D3jliXYYQM2vZxweeP9rntbtwvnBOkegIDu7SKpdTMvGQpiPVnM4csA5uO0es7o4NrdukHiE0pnmBQf+5baZjGY0QreKYRPrwQlEJCA/W2D97m233oW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(2906002)(83380400001)(66899021)(2616005)(38070700005)(33656002)(38100700002)(36756003)(86362001)(122000001)(41300700001)(26005)(6506007)(186003)(53546011)(54906003)(5660300002)(316002)(91956017)(6486002)(6512007)(76116006)(6916009)(66946007)(4326008)(71200400001)(64756008)(66556008)(8936002)(8676002)(66476007)(66446008)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XdTCYLLRl0Eei+xKX8B7SPBGOuMmasrq4uU7kzfbhYZkOKqQtRToEqxG47Aq?=
 =?us-ascii?Q?C9NmOZ9InPgDL9qTGmmJ6md72meyGiL2nm/75UBBx+GYx08MTMN3+oWHiqPM?=
 =?us-ascii?Q?RdKw31JP4f5aJ73Y6Kimhpu645ctFxbCkQLIZ+j3nmXsz0/0LA3aKoi7Zw0R?=
 =?us-ascii?Q?dnBmrlZc1C+fCnE8F+yJ67J7Y59fWRQK2Rov6styoV9z+bn//QVX+oW9x2l8?=
 =?us-ascii?Q?KcJPllR7j+8D30tcNXXL8jzVXl74RaW0DidA/2/OfAnRN06TaGaY5dYKhmxa?=
 =?us-ascii?Q?8aO1fYxFpId4hoGJBhiVkwI0BrwuqAvwuHvvFVzeTIoGf6EDeHtKxfL8YH3Q?=
 =?us-ascii?Q?uOdyr99HHtVvwgJdVDmgzVhyeejDhTyNc/gJ9ZB/vn6yaMheTI2VvCy/2bsM?=
 =?us-ascii?Q?vn4lBz9RqpYGI8oWQkqJqFxDrzSdTcXOJhFoLqsuawWoqcsP7frvvSIG1COS?=
 =?us-ascii?Q?mFJuKHPYFVwSF5OAzmzPElBAXdRs8ThT+id2F7O0jjMD3qZCo5Uwzzo+shYw?=
 =?us-ascii?Q?swb5q1CgrVJMk9g0ge0Z2ifaisEKrM08/CmjmPOpJY5u0tLP6zHWOnLOtAlv?=
 =?us-ascii?Q?Llk4pKQ78Cl+Vm9FceWff9Rtfe5aTAQ6tz/viwzNl0vAvRAHp2wOM9XL0o4A?=
 =?us-ascii?Q?EMC7tNTfelBUkh8CLllbxBGnQi6OT1yCW7eNCpb69wUDQgkp+PySfBOObRzE?=
 =?us-ascii?Q?CyiEmkAPqDiUgF8HiMWlYT6kOSOahyxv2fBQFJSlVHA6Rz8/erAeUOj/UH3S?=
 =?us-ascii?Q?B6Wdxr0gk9m7aDAjupN1jzh5Q8MhB2JQzBpAOD7XiLwfLQf3dyzSet8QNwEl?=
 =?us-ascii?Q?JSMSJdjgqNP7G8SI6WVvk0xMSDMpryAyCe9iezTJnk3qnSoMSDiuefxhp/I6?=
 =?us-ascii?Q?7QuyKCRiXa952H0ozLDdlHdOla8fWutUoHS5QTAoXGfvpANeXn86Up6epAPr?=
 =?us-ascii?Q?xxqeZSMrSxWAYGm1LHSeUYp4/vo5kL9b6Hs8CtwtjJ6m8MnZ9AZbjM7bTn7b?=
 =?us-ascii?Q?CAuQ9Xi4ILOousurGaUiyMuqkxL7BdVCdkI/ovDaV8atcwlF0zg5VIpGezr+?=
 =?us-ascii?Q?MGBAtnDQfTZrHJjdvsWHQECvy2i6nXCQbuesRzCPgvF0eg1QGvGUkNjizIfd?=
 =?us-ascii?Q?foa4HXuHYL2URe0wIzIX814sRmndSGTQjBD3QCAkbyS6Tdmx5F+cEJq7+jZN?=
 =?us-ascii?Q?CbOC+q8QXY54guwfVHVKd0dvaXFtGbbaxHRZt5pB0/gvmTbM6xRYa2DxTFCR?=
 =?us-ascii?Q?dA0j7AWNDY1zMD2YigfYub+X50vwHsV4f/XRDYVpUw7RDenUt3z8/4mnitqF?=
 =?us-ascii?Q?ZyCZXPu056Pt69iUE1SCm/8t246BA2RXhYZ1vNtw/JvGsCJK2J5XCuatgcz5?=
 =?us-ascii?Q?E7fi8zJzRP6RzW7gCEmdHvCUMXnnOfe7HXS/bQ5Q1OW7++hcH0p6HIZWKgaA?=
 =?us-ascii?Q?yAP4a5E9Gb71/W3zistlpdH/M4g7aryI6FAghMdqWzylaM54vXe69Og3pxU0?=
 =?us-ascii?Q?dO1+4lFGAIllIovmKwFFpjdOnNbBLsEtPP/Ffc4cXyxzTOFGA7+syQKkY2BF?=
 =?us-ascii?Q?ZppVrqyVlgrQhlNEnda1kHARfI/N5ay2Sjh9cWuxG2bjoyjEdTUNm6SwEweL?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <341616AA31BD3145B8C3C2367EAB0845@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5cRPUqg6bAzJOUzgznwYLV5/KydmuSqO+mi5+72nJk7mj2RAsU9HDG9nLBQaCM2J4olbUeZIgNJlDAjBU5f0I13EYP70GU2K22x2JFDPA1nG/xUPmBGOSD2sjdtHabNCYVhyMQlElWWgRwWhV20jBKHRXZ+Nd4Y+9o1LQEGQVOqvYOP6TjPlsR/z90MkZ0tWYvFwlMI9x+KuuR0O/l+N74+YT7jnMmpJdlMq6t9Uw7zthEE6iSdUNsXeSTuPMWdyJN2eyE3F/PIQ1lVbVtKOOoc21SLrGLuXb/2t3ZP+6/PHJAXqUAVrJ3C+NRmFh0qoCfTHddnWnWcV4onnOPMdrvcS8LKxeIB/6MEgfQV9qEnORzdE2XurRp5eezuI3Ih5lcuHJ5LxO5/R0rH/o8C0WerwDPJ6KDfn6aeWt3+zMoyoDx57toIexqAQjKCsqyyc0JfCDbqnzomOIrVK+Wcv6H1G+rR2xj0DyHQeB8BbmFqS6RBpw57o+w/hPYrRJ3zzN67vYJZs/epzBeJLw7P48x7aaPe5nxlK76cGFM71iEE1IibG0m3HMecopSwIdONqGjXkbqiWtp9eB9p14dJHb7LE3Ir54OF8ySO+h4XCk0Xx0v0D0e0blk9bUnPBMSVANsw8t4wav0b7YkUJM1o+eHh2kxyILsXUO1yCqM39duuPEL5ol2SB/hiLzfAEvA3ysr8hR6YkNw7PeUa/jH/vEUY/IUI+tusHqwXCUjwTmcTaCjbexw7D29LexuY9oWzePzlVpCbAoB+MHuW47VfK3LpBnZe1ZoI/mqlGNQTi9OB+7VLw27gKY5k5NnzLvkWe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cf92b4-1e20-4928-4ef4-08db84707c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 13:44:45.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +py3xESykpMNO4IRJ+fdd5iS8HRPemLcDYDDdv/henxN67TdTNQSuiENrez+29sLor14oEN8m9sMcz7K4+kgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=841 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140124
X-Proofpoint-ORIG-GUID: d5kuzkjTLBpGJzCi_1egocErz9OyO4ic
X-Proofpoint-GUID: d5kuzkjTLBpGJzCi_1egocErz9OyO4ic
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2023, at 9:26 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2023-07-09 at 16:04 -0400, Chuck Lever wrote:
>> After some discussion with David Howells at LSF/MM 2023, we arrived
>> at a plan to use a single sock_sendmsg() call for transmitting an
>> RPC message on socket-based transports. This is an initial part of
>> the transition to support handling folios with file content, but it
>> has scalability benefits as well.
>>=20
>> Comments, suggestions, and test results are welcome.
>>=20
>> ---
>>=20
>> Chuck Lever (4):
>>      SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
>>      SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec arra=
y
>>      SUNRPC: Use a per-transport receive bio_vec array
>>      SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
>>=20
>>=20
>> include/linux/sunrpc/svc.h     |   1 -
>> include/linux/sunrpc/svcsock.h |   7 ++
>> net/sunrpc/svcsock.c           | 142 ++++++++++++++++++---------------
>> 3 files changed, 86 insertions(+), 64 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> Aside from my concerns with bounds checking on the first patch, this
> looks like a good set of changes overall. Does it show any performance
> improvements in your testing?

At the moment I'm mostly interested in not causing behavior regressions.

I plan to look at instruction path length and such once we've agreed
on the form of this change. With TCP, there are enough bottlenecks
that this kind of modification won't translate into much of a
performance delta observed at the client, but it might improve
scalability on the server.

When it's available in a git repo, I can ask Daire to try it out too.


--
Chuck Lever


